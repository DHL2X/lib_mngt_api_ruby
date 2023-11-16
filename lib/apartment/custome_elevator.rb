module Apartment
    class CustomElevator < Elevators::Generic
        def parse_tenant_name(request, _opts = {})
            res=request.env['HTTP_SERVER']
            Apartment::Tenant.switch!(res)
            rescue =>e #return to public server
                Apartment::Tenant.switch!("public")
            
        end
    end
end