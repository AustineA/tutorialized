module Variant
  extend ActiveSupport::Concern

  included do
    def self.thumbnail_options
      {
        resize: "400x320^",
        gravity: "center",
        # extent: "400x320",
        strip: true,
        'sampling-factor': "4:2:0",
        quality: "40",
        interlace: "JPEG",
        colorspace: "sRGB",
      }
    end

    def self.medium_options
      {
        resize: "600x400^",
        gravity: "center",
        strip: true,
        'sampling-factor': "4:2:0",
        quality: "50",
        interlace: "JPEG",
        colorspace: "sRGB",
      }
    end

    def self.large_options
      {
        resize: "1000x1000^",
        gravity: "center",
        strip: true,
        'sampling-factor': "4:2:0",
        quality: "50",
        interlace: "JPEG",
        colorspace: "sRGB",
      }
    end
  end
end
