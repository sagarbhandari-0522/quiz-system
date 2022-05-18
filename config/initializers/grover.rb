# frozen_string_literal: true

Grover.configure do |config|
  config.options = {
    format: 'A4',
    margin: {
      top: '5px'
    },
    viewport: {
      width: 640,
      height: 480
    },
    prefer_css_page_size: true,
    emulate_media: 'screen',
    cache: false,
    # Timeout in ms. A value of `0` means 'no timeout'
    timeout: 0,
    wait_until: 'domcontentloaded'
  }
end
