module ApplicationHelper

  def full_title(page_name = "")
    base_title = "Sample"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end
  
  def convert_text_to_url(text)
    ## 引数のテキストから、URIを抜き出す。
    ## →URL。ここの場合、リンクが欲しいので、http,https。指定するだけでそのまま指定したものを丸ごと全部抜き出せる
    ## uniqは同じURLがある可能性があり、重複してループするのを避けるために入れている。
    URI.extract(text, ['http','https']).uniq.each do |url|
      ## 何回も使うので初期化
      sub_text = ""
      
      ## 文字列追加、バクスラはダブルコーテーションを入れるためのエスケープシーケンス
      ## targetはリンクの表示方法、これは新しく開いて画面に表示させる。
      sub_text << "<a href=" << url << " target=\"_blank\">" << url << "</a>"
      
      ## 文字置き換え。textないのurlを全て置換。これで重複した物も変更される
      text.gsub!(url, sub_text)
    end
    return text
  end
end