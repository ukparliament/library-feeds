xml.rss( :version => '2.0', 'xmlns:atom' => 'http://www.w3.org/2005/Atom' ) do
	xml.channel do
		xml.title( @page_title )
		xml.description( "Updates whenever a new publication is published." )
		xml.link( publication_list_url )
		xml.copyright( 'https://www.parliament.uk/site-information/copyright-parliament/open-parliament-licence/' )
		xml.language( 'en-uk' )
		xml.managingEditor( 'somervillea@parliament.uk (Anya Somerville)' )
		xml.pubDate( @publications.first.published_at.rfc822 ) unless @publications.empty?
		xml.tag!( 'atom:link', { :href => publication_list_url( :format => 'rss' ), :rel => 'self', :type => 'application/rss+xml' } )
		xml << render( :partial => 'publication/publication', :collection => @publications ) unless @publications.empty?
	end
end