require 'deadweight'

desc "run Deadweight CSS check (requires script/server)"
Deadweight::RakeTask.new do |dw|
  dw.stylesheets = ["/assets/access.css",  "/assets/collection.css",  "/assets/product_listing.css", "/assets/scrap.css", "/assets/share.css"]
  dw.pages = ["/", "/scrap/view_scrap_detail/1", "/scrap/edit/1"]
  puts dw.run
end