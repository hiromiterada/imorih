this.select_kind = (kind) ->
  if kind is 'monthly_parking'
    $('#select-parking-form').show()
  else
    $('#select-parking-form').hide()
  return

this.select_parking = (id) ->
  $.ajax
    url: '/parkings/' + id + '/areas/'
    type: 'GET'
    dataType: 'json'
    success: (data, status, xhr) ->
      $('#select-areas-form').empty()
      $.each data, ->
        area_id = 'area_id_' + this.id
        input = $('<input type="checkbox" />').attr(
          id: area_id
          name: 'contract[area_ids][]'
          value: this.id
        )
        label = $('<label>').attr(for: area_id).text(this.name)
        $("#select-areas-form").append(input).append label
      return
  return
