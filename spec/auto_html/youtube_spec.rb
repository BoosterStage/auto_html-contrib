# frozen_string_literal: true

require 'spec_helper'

RSpec.describe AutoHtml::YouTube do
  it 'transforms youtube url' do
    result = subject.call('https://www.youtube.com/watch?v=BwNrmYRiX_o')
    expect(result).to eq '<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/BwNrmYRiX_o" frameborder="0" allowfullscreen="yes"></iframe></div>'
  end

  it 'transforms youtube url in its own paragraph' do
    result = subject.call(%(Text above

https://www.youtube.com/watch?v=BwNrmYRiX_o

Text below))
    expect(result).to eq %(Text above

<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/BwNrmYRiX_o" frameborder="0" allowfullscreen="yes"></iframe></div>

Text below)
  end

  it 'transforms youtube url with lot of params' do
    result = subject.call('https://www.youtube.com/watch?v=BwNrmYRiX_o&eurl=http%3A%2F%2Fvukajlija.com%2Fvideo%2Fklipovi%3Fstrana%3D6&feature=player_embedded') { youtube }
    expect(result).to eq '<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/BwNrmYRiX_o" frameborder="0" allowfullscreen="yes"></iframe></div>'
  end

  it 'does not transform inline YouTube URL' do
    result = subject.call('inline https://www.youtube.com/watch?v=fT1ahr81HLw is ignored') { youtube }
    expect(result).to eq 'inline https://www.youtube.com/watch?v=fT1ahr81HLw is ignored'
  end

  it 'transforms url without www' do
    result = subject.call('https://youtube.com/watch?v=BwNrmYRiX_o') { youtube }
    expect(result).to eq '<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/BwNrmYRiX_o" frameborder="0" allowfullscreen="yes"></iframe></div>'
  end

  it 'transforms short url' do
    result = subject.call('https://www.youtu.be/BwNrmYRiX_o')
    expect(result).to eq '<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/BwNrmYRiX_o" frameborder="0" allowfullscreen="yes"></iframe></div>'
  end

  it 'transforms short url with params' do
    result = subject.call('https://youtu.be/t7NdBIA4zJg?t=1s&hd=1')
    expect(result).to eq '<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/t7NdBIA4zJg" frameborder="0" allowfullscreen="yes"></iframe></div>'
  end

  it 'transforms https url' do
    result = subject.call('https://www.youtube.com/watch?v=t7NdBIA4zJg')
    expect(result).to eq '<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/t7NdBIA4zJg" frameborder="0" allowfullscreen="yes"></iframe></div>'
  end

  it 'transforms url without protocol' do
    result = subject.call('www.youtube.com/watch?v=t7NdBIA4zJg')
    expect(result).to eq '<div class="video youtube"><iframe width="420" height="315" src="//www.youtube.com/embed/t7NdBIA4zJg" frameborder="0" allowfullscreen="yes"></iframe></div>'
  end

  it 'ignores url inside <pre> tag' do
    result = subject.call('<pre>https://www.youtube.com/watch?v=fT1ahr81HLw</pre>') { youtube }
    expect(result).to eq '<pre>https://www.youtube.com/watch?v=fT1ahr81HLw</pre>'
  end
end
