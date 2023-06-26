require "rspec/expectations"

module IncludePaginationHeaders
  extend RSpec::Matchers::DSL

  #
  # RSpec matcher para verificar headers de paginação de uma requisição
  #
  # Atributos obrigatórios
  # - per_page: inteiro - número de registros listados por página
  # - page: inteiro - número da página atual
  # - total: inteiro - número total de registros listados
  # Uso:
  # ```
  # it { expect(response).to include_pagination_headers(per_page: 1, page: 2, total: 3) }
  # ```

  matcher :include_pagination_headers do |per_page:, page:, total_page:, total:|
    match do |response|
      unless response
        @failure_message_continuation = "it didn't include a valid response"
        return false
      end

      @per_page = per_page.to_i
      @page = page.to_i
      @total = total.to_i
      @total_page = total_page.to_i

      next_raw_page = @page + 1
      @last_page = (@total / @per_page.to_f).ceil
      @next_page = if next_raw_page > @total
                     nil
                   elsif next_raw_page > @last_page
                     @last_page
                   else
                     next_raw_page
                   end

      @last_page = nil if @next_page.nil?


      includes_per_page? &&
        includes_page? &&
        includes_total? &&
        includes_total_pages? # && includes_links?
    end

    def includes_per_page?
      @failure_message_continuation = "it included X-Per-Page=\"#{response.headers["X-Per-Page"]}\" instead of \"#{@per_page}\""

      response.headers["X-Per-Page"] == @per_page.to_s
    end

    def includes_page?
      @failure_message_continuation = "it included X-Page=\"#{response.headers["X-Page"]}\" instead of \"#{@page}\""

      response.headers["X-Page"] == @page.to_s
    end

    def includes_total_pages?
      @failure_message_continuation = "it included X-Total=\"#{response.headers["X-Total-Page"]}\" instead of \"#{@total_page}\""

      response.headers["X-Total-Page"] == @total_page.to_s
    end

    def includes_total?
      @failure_message_continuation = "it included X-Total=\"#{response.headers["X-Total"]}\" instead of \"#{@total}\""

      response.headers["X-Total"] == @total.to_s
    end

    def includes_links?
      # quando o numero  de recursos por pagina é maior que o total,
      # o Link não é gerado pois não existe next/last pages
      @failure_message_continuation = "Link pagination isn't nil"
      return response.headers["Link"].nil? if @per_page > @total

      includes_next_link? && includes_last_link? && include_window_links?
    end

    def includes_last_link?
      return true if @last_page.nil?

      @failure_message_continuation = "Link doesn't include ?page=#{@last_page} with rel=\"last\" as last page link"
      response.headers["Link"].include? "?page=#{@last_page}>; rel=\"last\""
    end

    def includes_next_link?
      return true if @next_page.nil?

      @failure_message_continuation = "Link doesn't include ?page=#{@next_page} with rel=\"next\" as next page link"
      response.headers["Link"].include? "?page=#{@next_page}>; rel=\"next\""
    end

    def include_window_links?
      # caso a pagina seja a primeira, nao são gerado os links prev/first
      return true if @page.to_i == 1

      includes_prev_link? && includes_first_link?
    end

    def includes_prev_link?
      # caso a pagina seja a primeira, nao são gerado o links prev/first
      return true if @page.to_i == 1

      prev_page = @page.to_i - 1

      @failure_message_continuation = "Link doesn't includes ?page=#{prev_page} with rel=\"prev\" as previous page link"
      response.headers["Link"].include? "?page=#{prev_page}>; rel=\"prev\""
    end

    def includes_first_link?
      # caso a pagina seja a primeira, nao são gerado o links prev/first
      return true if @page.to_i == 1

      # teoricamente a primeira pagina sempre é a numero 1
      @failure_message_continuation = "Link doesn't includes ?page=1 with rel=\"first\" as first page link"
      response.headers["Link"].include? "?page=1>; rel=\"first\""
    end


    description do
      "include X-Page, X-Per-Page, X-Total-Page, X-Total and Link pagination headers"
    end

    failure_message do
      message = "expected response to include X-Page, X-Per-Page, X-Total-Page, X-Total and Link pagination headers but "
      message += @failure_message_continuation.to_s + "."
    end
  end
end

RSpec.configure do |config|
  config.include IncludePaginationHeaders, type: :request
end
