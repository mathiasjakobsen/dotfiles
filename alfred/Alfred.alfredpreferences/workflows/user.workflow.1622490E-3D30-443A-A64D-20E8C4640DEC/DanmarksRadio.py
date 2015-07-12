#!/usr/bin/python
# -*- coding: utf-8 -*-
import urllib2
import json
import re
import operator
from datetime import datetime
from datetime import date
from dateutil.relativedelta import relativedelta

class DanmarksRadio(object):
	def search(self, term):
		'''Search DR TV for shows and return results'''
		if not '*' in term:
			term = '%s*' % (term)
		path = 'Search/Bundle?Title=$like(\'%s\')' % urllib2.quote(term)
		return self.__load_path(path)

	def search_parsed(self, term, load_program_cards = False):
		'''Search DR TV for shows and return results as instances of DanmarksRadioSearchResult'''
		response = self.search(term)
		results = []
		if response is not None:
			items = response['Data']
			for item in items:
				if 'Slug' in item and 'Title' in item and 'Relations' in item:
					# Check if we can find an image for the program
					image_url = None
					if 'Assets' in item:
						for asset in item['Assets']:
							if asset['ContentType'] == 'image/jpeg':
								image_url = asset['Uri']
								break
					result = DanmarksRadioSearchResult(
						item['Slug'],
						item['Title'],
						self.__safe_value('OnlineGenreText', item),
						image_url,
						self.program_cards_parsed(item['Slug']) if load_program_cards else None
					)
					results.append(result)
		return results

	def program_cards(self, slug):
		'''Loads the program information for the specified slug'''
		path = 'programcard?Relations.Slug=$eq(\'%s\')&limit=$eq(100)' % urllib2.quote(slug)
		return self.__load_path(path)

	def program_cards_parsed(self, slug):
		'''Loads the program information for the specified slug as instances of DanmarksRadioProgramCard'''
		response = self.program_cards(slug)
		cards = []
		if response is not None:
			items = response['Data']
			for item in items:
				card = self.__parse_program_card(item)
				if card is not None:
					cards.append(card)
		return cards

	def most_viewed(self, start_date, timespan):
		'''Loads the most viewed programs for a period'''
		path = 'ProgramViews/MostViewed?from=%s&span=%s' % (start_date, timespan)
		return self.__load_path(path)

	def most_viewed_parsed(self, start_date, timespan):
		'''Loads the most viewed programs and parses them into instances of DanmarksRadioProgramCard'''
		response = self.most_viewed(start_date, timespan)
		cards = []
		if 'Data' in response:
			for item in response['Data']:
				if 'ProgramCard' in item:
					card = self.__parse_program_card(item['ProgramCard'])
					if card is not None:
						if 'TotalViews' in item:
							card.total_views = item['TotalViews']
						cards.append(card)
		return cards

	def most_viewed_this_week(self):
		'''Loads the most viewed programs for this week'''
		today = date.today()
		previous_week = today + relativedelta(weeks = -1)
		timespan = '%s:00:00:00' % ((today - previous_week).days)
		return self.most_viewed_parsed(previous_week, timespan)

	def get_direct_video_url(self, video_url):
		'''Gives a direct video URL'''
		response = self.__load_url(video_url)
		if response is not None and 'Links' in response:
			links = response['Links']
			download_link = None
			for link in links:
				if link['Target'] == 'HLS' and link['FileFormat'] == 'mp4':
					download_link = link['Uri']
					break
		return download_link

	def __parse_program_card(self, item):
		'''Parses a program card item'''
		if 'Slug' in item and 'Title' in item and 'Relations' in item:
			for relation in item['Relations']: # Find the "parent program" slug, used for the pag eurl
				if relation['BundleType'] == 'Series':
					program_slug = relation['Slug']
					break
			if program_slug is None: # Don't add the relation if we could not find parent slug
				return
			image_url = None
			video_url = None
			# Check if we can find an image and a video url for the image
			if 'Assets' in item:
				for asset in item['Assets']:
					if asset['Kind'] == 'Image':
						image_url = asset['Uri']
					elif asset['Kind'] == 'VideoResource':
						video_url = asset['Uri']
					if image_url != None and video_url != None:
						break # We found both an image and a video URL
			if 'PrimaryBroadcastStartTime' in item: # Try to figure out when the program was broadcasted
				broadcast_time_str = item['PrimaryBroadcastStartTime']
				regex_milliseconds = r'^\d{4}-\d{1,2}-\d{1,2}T\d{1,2}:\d{1,2}:\d{1,2}\.\d{1,4}Z$'
				regex_no_milliseconds = r'^\d{4}-\d{1,2}-\d{1,2}T\d{1,2}:\d{1,2}:\d{1,2}Z$'
				if re.compile(regex_no_milliseconds).match(broadcast_time_str) is not None:
					broadcast_time = datetime.strptime(broadcast_time_str, '%Y-%m-%dT%H:%M:%SZ')
				elif re.compile(regex_milliseconds).match(broadcast_time_str) is not None:
					broadcast_time = datetime.strptime(broadcast_time_str, '%Y-%m-%dT%H:%M:%S.%fZ')
				else:
					print broadcast_time_str
					broadcast_time = None
			else:
				broadcast_time = None
			card = DanmarksRadioProgramCard(
				program_slug,
				item['Slug'],
				item['Title'],
				self.__safe_value('GenreText', item),
				self.__safe_value('Description', item),
				broadcast_time,
				image_url,
				video_url
			)
			return card

	def __load_path(self, path):
		'''Load and parse the response of a request'''
		url = 'http://www.dr.dk/mu/%s' % path
		return self.__load_url(url)

	def __load_url(self, url):
		'''Load and parse the response of a request'''
		response = urllib2.urlopen(url)
		contents = response.read()
		try:
			return json.loads(contents)
		except ValueError, e:
			return None

	def __safe_value(self, key, pair):
		'''Safely retrieves the value for the specified key in the specified dictionary'''
		return pair[key] if key in pair else None

class DanmarksRadioProgram(object):
	def __init__(self, slug, title, genre, image_url):
		self.__slug = slug
		self.__title = title
		self.__genre = genre
		self.__image_url = image_url

	@property
	def image_url(self):
		return self.__image_url

	@property
	def slug(self):
		return self.__slug

	@property
	def title(self):
		return self.__title

	@property
	def genre(self):
		return self.__genre

class DanmarksRadioSearchResult(DanmarksRadioProgram):
	def __init__(self, slug, title, genre, image_url, video_url, program_cards = None):
		super(self.__class__, self).__init__(slug, title, genre, image_url)
		self.__program_cards = program_cards

	@property
	def program_cards(self):
		return self.__program_cards

	@property
	def page_url(self):
		return 'http://www.dr.dk/tv/se/%s' % (self.slug)

class DanmarksRadioProgramCard(DanmarksRadioProgram):
	def __init__(self, program_slug, slug, title, genre, description, broadcast_time, image_url, video_url):
		super(self.__class__, self).__init__(slug, title, genre, image_url)
		self.__program_slug = program_slug
		self.__description = description
		self.__broadcast_time = broadcast_time
		self.__video_url = video_url
		self.total_views = -1

	@property
	def program_slug(self):
		return self.__program_slug

	@property
	def description(self):
		return self.__description

	@property
	def broadcast_time(self):
		return self.__broadcast_time

	@property
	def video_url(self):
		return self.__video_url

	@property
	def page_url(self):
		return 'http://www.dr.dk/tv/se/%s/%s' % (self.program_slug, self.slug)

	@property
	def is_available(self):
		return self.__video_url != None
