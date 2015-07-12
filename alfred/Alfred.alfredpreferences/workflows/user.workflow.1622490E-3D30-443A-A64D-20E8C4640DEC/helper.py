#!/usr/bin/python
# -*- coding: utf-8 -*-
from DanmarksRadio import DanmarksRadio
from Feedback import Feedback
from subprocess import Popen, PIPE
from subprocess import call
import re
import urllib
import os
import webbrowser
import urllib
import urlparse
import time
import locale

locale.setlocale(locale.LC_ALL, '')

def helper(query):
	'''Entry point for Alfred'''
	if len(query) == 0:
		feedback = Feedback()
		feedback.add_item('Browse DR TV', '', '', 'no', '')
		feedback.add_item('Most viewed this week', '', '', 'no', '-week')
		return feedback
	else:
		regex_program_slug = r'^(?P<term>.*) > (?P<slug>.*)$'
		matches_program_slug = re.compile(regex_program_slug).match(query)
		if matches_program_slug is not None:
			term = matches_program_slug.group('term')
			slug = matches_program_slug.group('slug')
			return program_cards_for_slug(query.decode('utf-8'), term.decode('utf-8'), slug)
		elif query == '-week':
			return most_viewed_this_week(query)
		else:
			return search(query)

def search(query):
	'''Searches DR TV'''
	if len(query) < 3: # Minimum length of search query
		feedback = Feedback()
		feedback.add_item('Browse DR TV', '', '', 'no', query)
		return feedback
	danmarks_radio = DanmarksRadio()
	results = danmarks_radio.search_parsed(query)
	feedback = Feedback()
	if len(results) == 0:
		feedback.add_item('No results found for \'%s\'' % (query), '', '', 'no', query, 'images/icon-gray.png')
	else:
		for result in results:
			autocomplete = '%s > %s' % (query.decode('utf-8'), result.slug)
			icon_path = 'icon.png'
			if result.image_url is not None:
				icon_path = store_thumb(result.image_url, result.slug)
			feedback.add_item(result.title, result.genre, '', 'no', autocomplete, icon_path)
	return feedback
	
def most_viewed_this_week(query):
	danmarks_radio = DanmarksRadio()
	results = danmarks_radio.most_viewed_this_week()
	if len(results) == 0:
		feedback = Feedback()
		feedback.add_item('No programs found', '', '', 'no', '', 'images/icon-gray.png')
	else:
		feedback = feedback_for_program_cards(query, results)
	return feedback
	
def program_cards_for_slug(query, term, slug):
	'''Show program cards for a slug'''
	danmarks_radio = DanmarksRadio()
	results = danmarks_radio.program_cards_parsed(slug)
	feedback = None
	if len(results) == 0:
		feedback = Feedback()
		feedback.add_item('No programs found', '', '', 'no', '', 'images/icon-gray.png')
	else:
		feedback = feedback_for_program_cards(query, results)
	feedback.add_item('Go back', '', '', 'no', term, 'images/back.png')
	return feedback
	
def feedback_for_program_cards(query, program_cards):
	feedback = Feedback()
	for card in program_cards:
		icon_path = 'icon.png'
		subtitle = ''
		if card.image_url is not None:
			icon_path = store_thumb(card.image_url, '%s-%s' % (card.program_slug, card.slug))
		if card.genre != None and card.broadcast_time != None:
			subtitle = '%s, %s' % (card.genre, card.broadcast_time.strftime('%d. %b. %Y'))
		elif card.genre != None:
			subtitle = card.genre
		elif card.genre != None:
			subtitle = card.broadcast_time.strftime('%d. %b. %Y')
		if card.total_views is not -1:
			if len(subtitle) > 0:
				subtitle = '%s, %i views' % (subtitle, card.total_views)
			else:
				subtitle = '%i views' % (card.total_views)
		if not card.is_available:
			if len(subtitle) > 0:
				subtitle = '%s (Unavailable)' % (subtitle)
			else:
				subtitle = 'Unavailable'
			icon_path = 'images/icon-gray.png'
		args = {
			'slug': card.slug,
			'video_url': card.video_url,
			'page_url': card.page_url
		}
		is_valid = 'yes' if card.is_available else 'no'
		autocomplete = query if not card.is_available else ''
		feedback.add_item(card.title, subtitle, urllib.urlencode(args, doseq = True), is_valid, autocomplete, icon_path)
	return feedback
	
def store_thumb(url, name):
	'''Store thumbnail if it doesn't exist'''
	directory = 'thumbs'
	if not os.path.isdir(directory):
		os.makedirs(directory)
	icon_path = '%s/%s.jpeg' % (directory, name)
	if not os.path.isfile(icon_path):
		urllib.urlretrieve('%s?width=60' % (url), icon_path)
	return icon_path
	
def run_cmd(cmd):
	'''Runs a command'''
	p = Popen(cmd, stdin=PIPE, stdout=PIPE, stderr=PIPE)
	stdout, stderr = p.communicate()
	return stdout

def is_iterm2_installed():
	'''Checks if iTerm 2 exists'''
	resp = run_cmd(["osascript", "apps/app-installed.app", "com.googlecode.iterm2"])
	return (resp.strip() == '1')
	
def action_open_program(query):
	'''Action called by Alfred to open a program'''
	params = urlparse.parse_qs(query)
	if 'page_url' in params:
		webbrowser.open(params['page_url'][0])
	
def action_download_program(query):
	'''Starts the download of a program'''
	params = urlparse.parse_qs(query)
	if 'slug' in params and 'video_url' in params:
		danmarks_radio = DanmarksRadio()
		direct_video_url = danmarks_radio.get_direct_video_url(params['video_url'][0])
		if direct_video_url is None:
			run_cmd(["osascript", "apps/display-notification.app", "I was unable to download the video.", "This is embarrasing..."])
		else:
			if is_iterm2_installed():
				run_cmd(["osascript", "apps/download-using-iterm.app", direct_video_url, params['slug'][0]])
			else:
				run_cmd(["osascript", "apps/download-using-terminal.app", direct_video_url, params['slug'][0]])