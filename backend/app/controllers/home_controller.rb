class HomeController
  def index(req)
    # frontend/public/index.html を返す（Reactアプリのエントリーポイント）
    file_path = File.expand_path('../../../frontend/public/index.html', __FILE__)
    if File.exist?(file_path)
      content = File.read(file_path)
      [200, { "Content-Type" => "text/html" }, [content]]
    else
      [404, { "Content-Type" => "text/plain" }, ["Not Found"]]
    end
  end
end
