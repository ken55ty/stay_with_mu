module MusicsHelper
  def levelclass(level)
    case level
    when 1..4
      ""
    when 5..9
      "text-cyan-100"
    when 10..19
      "text-cyan-200"
    when 20..29
      "text-sky-300"
    when 30..39
      "text-sky-400"
    when 40..49
      "text-blue-600"
    when 50..69
      "text-yellow-400"
    when 70..99
      "text-orange-500"
    when 100
      "text-red-600"
    else
      ""
    end
  end
end