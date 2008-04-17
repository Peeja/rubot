module Rubot::Adapters::Aria
  class ActionDesired
    %w[ velocity delta_heading heading ].each do |channel|
      eval <<-CHAN_DEF
        private :set_#{channel}

        def #{channel}=(val)
          # Use current channel strength, or maximum (1) if not set.
          set_#{channel} val, (#{channel}_strength != 0 ? #{channel}_strength : 1)
        end

        def #{channel}_strength=(strength)
          set_#{channel} #{channel}, strength
        end
      CHAN_DEF
    end
  end
end
