local function add_lazy_loading(html)
  return html:gsub("(<img)([^>]*)>", function(tag, attributes)
    if attributes:match("%sloading%s*=")
      or attributes:match('class="[^"]*navbar%-logo[^"]*"') then
      return tag .. attributes .. ">"
    end
    return tag .. ' loading="lazy"' .. attributes .. ">"
  end)
end

function Image(image)
  if not image.attr.attributes.loading then
    image.attr.attributes.loading = "lazy"
  end
  return image
end

function RawBlock(block)
  if block.format == "html" then
    block.text = add_lazy_loading(block.text)
    return block
  end
end

function RawInline(inline)
  if inline.format == "html" then
    inline.text = add_lazy_loading(inline.text)
    return inline
  end
end
