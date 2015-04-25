module ApplicationHelper
  
  def generate_reg_code
    return generate_half_reg_code + '-' + generate_half_reg_code
   
  end
  
  def generate_half_reg_code
    #from http://stackoverflow.com/questions/22333237/generating-unique-hard-to-guess-coupon-codes
    
    # Random, unguessable number as a base20 string
    #  .reverse ensures we don't use first character (which may not take all values)
    raw_string = SecureRandom.random_number( 2**80 ).to_s( 20 ).reverse
    # e.g. "3ecg4f2f3d2ei0236gi"


    # Convert Ruby base 20 to better characters for user experience
    long_code = raw_string.tr( '0123456789abcdefghij', '234679QWERTYUPADFGHX' )
    # e.g. "6AUF7D4D6P4AH246QFH"


    # Format the code for printing
    short_code = long_code[0..3] + '-' + long_code[4..7] + '-' + long_code[8..11]  
    
    return short_code
  end

end
