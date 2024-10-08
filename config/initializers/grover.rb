# frozen_string_literal: true

Grover.configure do |config|
  config.options = {
    format: 'A4',
    margin: {
      top: '5px',
      bottom: '1cm'
    },
    viewport: {
      width: 1000,
      height: 600
    },
    prefer_css_page_size: true,
    emulate_media: 'screen',
    cache: false,
    # Timeout in ms. A value of `0` means 'no timeout'
    timeout: 0,
    request_timeout: 3000,
    convert_timeout: 2000,
    wait_until: 'domcontentloaded'
  }
end
