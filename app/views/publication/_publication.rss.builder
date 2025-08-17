xml.item do
	xml.guid( publication.link )
	xml.title( publication.title )
	xml.link( publication.link )
	xml.pubDate( publication.published_at.rfc822 )
end