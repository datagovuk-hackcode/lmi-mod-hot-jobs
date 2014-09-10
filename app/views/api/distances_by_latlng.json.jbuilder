json.response @response
json.cost number_to_currency( ((@distance[0..-4].to_f) * 0.24), unit: '£')