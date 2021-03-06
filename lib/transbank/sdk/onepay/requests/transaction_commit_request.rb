module Transbank
  module Onepay
    # Creates a request to Transbank attempting to commit a [Transaction]
    class TransactionCommitRequest
      include Request
      attr_reader :occ,  :external_unique_number, :issued_at, :signature

      SIGNATURE_PARAMS = [:occ,
                          :external_unique_number,
                          :issued_at].freeze
      # @param occ [String] Merchant purchase order
      # @param external_unique_number [String] a unique value (per Merchant, not global) that is used to identify a Transaction
      # @param issued_at [Integer] timestamp for when the transaction commit request was created
      def initialize(occ, external_unique_number, issued_at)
        self.occ = occ
        self.external_unique_number = external_unique_number
        self.issued_at = issued_at
        @signature = nil
      end

      # @param occ [String] Merchant purchase order
      def occ=(occ)
        raise Errors::TransactionCommitError, 'occ cannot be null.' if occ.nil?
        @occ = occ
      end

      # @param external_unique_number [String] a unique value (per Merchant, not global) that is used to identify a Transaction
      def external_unique_number=(external_unique_number)
        raise Errors::TransactionCommitError, 'external_unique_number cannot be null.' if external_unique_number.nil?
        @external_unique_number = external_unique_number
      end

      # @param issued_at [Integer] timestamp for when the transaction commit request was created
      def issued_at=(issued_at)
        raise Errors::TransactionCommitError, 'issued_at cannot be null.' if issued_at.nil?
        @issued_at = issued_at
      end

      # Create a signature string and assign it to @signature
      # @return [TransactionCommitRequest] self
      def sign(secret)
        @signature = signature_for(to_data, secret)
        self
      end

    end
  end
end
