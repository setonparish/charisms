require 'active_support/concern'

module Slugger
  extend ActiveSupport::Concern

  included do
    # easy to type identifier consisting
    # of lowercase alphanumeric characters
    # example:  "u4vlibt7mzyp"
    def easy_slug(length = 12)
      [*("a".."z"),*(0..9)].shuffle[0,length].join
    end
  end
end