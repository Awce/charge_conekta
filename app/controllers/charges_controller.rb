class ChargesController < ApplicationController
  def index
  end

  def create
    begin
      @charge = Conekta::Charge.create({
        amount: 1000,
        currency: "MXN",
        description: "Pizza Delivery",
        reference_id: "orden_de_id_interno",
        details: {
          email: "awce5nk@hotmail.com",
          line_items: [{
              "name" => "Box of Cohiba S1s",
              "description" => "Imported From Mex.",
              "unit_price" => 1000,
              "quantity" => 1,
              "sku" => "cohb_s1",
              "type" => "pizza-purchase"
          }]
        },
        card: params[:conektaTokenId]
      })
    rescue Conekta::ParameterValidationError => e
      puts e.message_to_purchaser
    #alguno de los parámetros fueron inválidos
    rescue Conekta::ProcessingError => e
      puts e.message_to_purchaser
    #la tarjeta no pudo ser procesada
    rescue Conekta::Error => e
      puts e.message_to_purchaser
    #un error ocurrió que no sucede en el flujo normal de cobros como por ejemplo un auth_key incorrecto
    end
  end

  def show
  end
end
