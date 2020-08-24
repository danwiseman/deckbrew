module SymbolsHelper

  # mtgSymbol Helper
  # This helper creates a pretty MTG symbol from the mana font. It has the following optional requirements:
  # cost: boolean. Show the cost color circle
  # shadow: boolean. Show a shadow under the symbol
  # size: int, 1-6. make it bigger
  # fixed_width: boolean. Show it as fixed_width
  def mtgSymbol(symbolText, options = {})
    options = {cost: true, shadow: false, size: 1, fixed_width: false}.merge(options)

    prettySymbol = ""
    classText = ""

    if(options[:cost])
      classText += "ms-cost "
    end
    if(options[:shadow])
      classText += "ms-shadow "
    end
    if(options[:size] > 1)
      classText += "ms-#{options[:size]}x "
    end
    if(options[:fixed_width])
      classText += "ms-fw "
    end

    case symbolText
    when '{T}'
      prettySymbol = tag.i class: "ms ms-tap #{classText}"
    when '{Q}'
      prettySymbol = tag.i class: "ms ms-untap #{classText}"
    when '{E}'
      prettySymbol = tag.i class: "ms ms-e #{classText}"
    when '{PW}'
      prettySymbol = tag.i class: "ms ms-planeswalker #{classText}"
    when '{CHAOS}'
      prettySymbol = tag.i class: "ms ms-chaos #{classText}"
    when '{X}'
      prettySymbol = tag.i class: "ms ms-x #{classText}"
    when '{Y}'
      prettySymbol = tag.i class: "ms ms-y #{classText}"
    when '{Z}'
      prettySymbol = tag.i class: "ms ms-z #{classText}"
    when '{0}'
      prettySymbol = tag.i class: "ms ms-0 #{classText}"
    when '{½}'
      prettySymbol = tag.i class: "ms ms-1-2 #{classText}"
    when '{1}'
      prettySymbol = tag.i class: "ms ms-1 #{classText}"
    when '{2}'
      prettySymbol = tag.i class: "ms ms-2 #{classText}"
    when '{3}'
      prettySymbol = tag.i class: "ms ms-3 #{classText}"
    when '{4}'
      prettySymbol = tag.i class: "ms ms-4 #{classText}"
    when '{5}'
      prettySymbol = tag.i class: "ms ms-5 #{classText}"
    when '{6}'
      prettySymbol = tag.i class: "ms ms-6 #{classText}"
    when '{7}'
      prettySymbol = tag.i class: "ms ms-7 #{classText}"
    when '{8}'
      prettySymbol = tag.i class: "ms ms-8 #{classText}"
    when '{9}'
      prettySymbol = tag.i class: "ms ms-9 #{classText}"
    when '{10}'
      prettySymbol = tag.i class: "ms ms-10 #{classText}"
    when '{11}'
      prettySymbol = tag.i class: "ms ms-11 #{classText}"
    when '{12}'
      prettySymbol = tag.i class: "ms ms-12 #{classText}"
    when '{13}'
      prettySymbol = tag.i class: "ms ms-13 #{classText}"
    when '{14}'
      prettySymbol = tag.i class: "ms ms-14 #{classText}"
    when '{15}'
      prettySymbol = tag.i class: "ms ms-15 #{classText}"
    when '{16}'
      prettySymbol = tag.i class: "ms ms-16 #{classText}"
    when '{17}'
      prettySymbol = tag.i class: "ms ms-17 #{classText}"
    when '{18}'
      prettySymbol = tag.i class: "ms ms-18 #{classText}"
    when '{19}'
      prettySymbol = tag.i class: "ms ms-19 #{classText}"
    when '{20}'
      prettySymbol = tag.i class: "ms ms-20 #{classText}"
    when '{100}'
      prettySymbol = tag.i class: "ms ms-100 #{classText}"
    when '{1000000}'
      prettySymbol = tag.i class: "ms ms-1000000 #{classText}"
    when '{∞}'
      prettySymbol = tag.i class: "ms ms-infinity #{classText}"
    when '{W/U}'
      prettySymbol = tag.i class: "ms ms-wu #{classText}"
    when '{W/B}'
      prettySymbol = tag.i class: "ms ms-wb #{classText}"
    when '{B/R}'
      prettySymbol = tag.i class: "ms ms-br #{classText}"
    when '{B/G}'
      prettySymbol = tag.i class: "ms ms-bg #{classText}"
    when '{U/B}'
      prettySymbol = tag.i class: "ms ms-ub #{classText}"
    when '{U/R}'
      prettySymbol = tag.i class: "ms ms-ur #{classText}"
    when '{R/G}'
      prettySymbol = tag.i class: "ms ms-rg #{classText}"
    when '{R/W}'
      prettySymbol = tag.i class: "ms ms-rw #{classText}"
    when '{G/W}'
      prettySymbol = tag.i class: "ms ms-gw #{classText}"
    when '{G/U}'
      prettySymbol = tag.i class: "ms ms-gu #{classText}"
    when '{2/W}'
      prettySymbol = tag.i class: "ms ms-2w #{classText}"
    when '{2/U}'
      prettySymbol = tag.i class: "ms ms-2u #{classText}"
    when '{2/B}'
      prettySymbol = tag.i class: "ms ms-2b #{classText}"
    when '{2/R}'
      prettySymbol = tag.i class: "ms ms-2r #{classText}"
    when '{2/G}'
      prettySymbol = tag.i class: "ms ms-2g #{classText}"
    when '{P}'
      prettySymbol = tag.i class: "ms ms-p #{classText}"
    when '{W/P}'
      prettySymbol = tag.i class: "ms ms-wp #{classText}"
    when '{U/P}'
      prettySymbol = tag.i class: "ms ms-up #{classText}"
    when '{B/P}'
      prettySymbol = tag.i class: "ms ms-bp #{classText}"
    when '{R/P}'
      prettySymbol = tag.i class: "ms ms-rp #{classText}"
    when '{G/P}'
      prettySymbol = tag.i class: "ms ms-gp #{classText}"
    when '{HW}'
      prettySymbol = tag.i class: "ms ms-hw #{classText}"
    when '{HR}'
      prettySymbol = tag.i class: "ms ms-hr #{classText}"
    when '{W}'
      prettySymbol = tag.i class: "ms ms-w #{classText}"
    when '{U}'
      prettySymbol = tag.i class: "ms ms-u #{classText}"
    when '{B}'
      prettySymbol = tag.i class: "ms ms-b #{classText}"
    when '{R}'
      prettySymbol = tag.i class: "ms ms-r #{classText}"
    when '{G}'
      prettySymbol = tag.i class: "ms ms-g #{classText}"
    when '{C}'
      prettySymbol = tag.i class: "ms ms-c #{classText}"
    when '{S}'
      prettySymbol = tag.i class: "ms ms-s #{classText}"
    else
      prettySymbol = symbolText
    end

    prettySymbol.html_safe

  end

  # prettyMtgText helper
  # This helper takes a long text and replaces all the MTG symbol texts with the nice mana font one
  # long_text: string. The text to replace with the nice stuff.
  # cost: boolean. Show the cost color circle
  # shadow: boolean. Show a shadow under the symbol
  # size: int, 1-6. make it bigger
  # fixed_width: boolean. Show it as fixed_width
  def prettyMtgText(long_text, options = {})
    options = {cost: true, shadow: false, size: 1, fixed_width: false}.merge(options)

    pretty_text = long_text.gsub(/{.+?}/) { |symbolText|
      mtgSymbol(symbolText, { cost: options[:cost], shadow: options[:shadow], size: options[:size],
        fixed_width: options[:fixed_width]} )
      }
    pretty_text.html_safe
  end

  # mtgSetSymbol Helper
  # This helper creates a pretty MTG set symbol from the keyrune font. It has the following optional requirements:
  # rarity: string, common, uncommon, rare, mythic, timeshifted
  # size: int, 1-6. make it bigger
  # fixed_width: boolean. Show it as fixed_width
  def mtgSetSymbol(setCode, options = {})
    options = {rarity: "common", size: 1, fixed_width: false}.merge(options)

    classText += "ss-#{options[:rarity]} "
    if(options[:size] > 1)
      classText += "ss-#{options[:size]}x "
    end
    if(options[:fixed_width])
      classText += "ss-fw "
    end
    prettySymbol = tag.i class: "ss ss-#{setCode} #{classText}"
    prettySymbol.html_safe
  end
end