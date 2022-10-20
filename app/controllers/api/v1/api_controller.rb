class Api::V1::ApiController < ApplicationController
  include ErrorHandling

  # TODO: RoutingErrorがそのままダンプされるので、middlewareレベルでhookして正しいjsonを返す様にする。
end
