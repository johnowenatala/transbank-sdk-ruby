module Transbank
  module Patpass
    module PatpassByWebpay
      module Errors
        class TransactionCommitError < ::Transbank::Patpass::Errors::PatpassError
          attr_reader :code
          def initialize(message, code)
            @code = code
            super(message, code)
          end
        end
      end
    end
  end
end
