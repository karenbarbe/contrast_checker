def validate_hex(input_hex)
  if input_hex == nil
    return false
  end

  hex = input_hex.strip.downcase

  if hex.length == 3 || hex.length == 6
    return hex =~ /\A[0-9a-f]+\z/ ?  true : false
    
  else
    return false
  end

end
