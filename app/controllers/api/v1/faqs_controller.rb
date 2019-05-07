class Api::V1::FaqsController < ApplicationController
    def index
        @faqs = Faq.all
        @faqs2 = @faqs.map { |faq| faq.new_faq_hash }
        render json: @faqs2, status: :ok
    end
end

