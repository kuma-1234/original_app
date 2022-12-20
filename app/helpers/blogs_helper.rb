module BlogsHelper
  def blog_content
    <<-"EOS".strip_heredoc
      散布で気づいたこと気になったことを入力しましょう！
      (例)初めて1キロ粒剤を散布した。説明書通りに散布したが剤が落ちすぎた。
      速度を少しあげて作業したらちょうど良く散布できた。
    EOS
  end
end
