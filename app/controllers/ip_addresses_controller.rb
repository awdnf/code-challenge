class IpAddressesController < ApplicationController

  def create
    ips = IpAddress.store(params["ip_list"])
    json_response(ips, :created)
  end

  def compute
    ips = IpAddress.compute
    json_response(ips, :ok)
  end

  private

  def allowed_params
    params.permit(:ip_list)
  end

end
