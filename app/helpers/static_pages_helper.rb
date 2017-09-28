module StaticPagesHelper
  def page_title
    title = "Demo" #ここにデフォルトの名前を入れてください。
    title = title if @page_title + "| Ruby on Rails Tutorial Sample App" 
    title
  end
end
