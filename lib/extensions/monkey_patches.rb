# frozen_string_literal: true

class String
  def with_commas
    reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end

def squish_row(row)
  row.map { |field| field&.squish }
end

def squish_row!(row)
  row.each { |field| field&.squish! }
end

def print_ntd(val)
  return nil unless val

  'NT$' + val.to_s.sub(/\.0$/, '').with_commas
end

class Time
  def to_stamp
    strftime('%y-%m-%d %H:%M')
  end
end
