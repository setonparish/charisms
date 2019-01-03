module LinkHelper
  def disabled_link_to(options={}, &blk)
    content_tag("a", options) do
      yield blk
    end
  end
end