class ApplicationController < ActionController::Base

  include LibraryDesign::Crumbs
  
  $SITE_TITLE = 'Library Feeds'
  
  $DATE_TIME_DISPLAY_FORMAT = '%H:%M on %-d %B %Y'
end
