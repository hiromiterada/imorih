this.select_kind = (kind) ->
  if kind is 'monthly_parking'
    $('#select-parking-form').show()
  else
    $('#select-parking-form').hide()
  return

this.select_owner = (id) ->
  $.ajax
    url: '/admin/parkings/'
    type: 'GET'
    dataType: 'json'
    success: (data, status, xhr) ->
      $('#contract_parking_id').empty()
      options = new Array()
      options.push(new Option('', ''))
      $.each data, ->
        options.push(new Option(this.name, this.id))
      $("#contract_parking_id").append(options)
      return
  return

this.select_parking = (id) ->
  $.ajax
    url: '/admin/parkings/' + id + '/areas/'
    type: 'GET'
    dataType: 'json'
    success: (data, status, xhr) ->
      $('#select-areas-form').empty()
      $.each data, ->
        area_id = 'area_id_' + this.id
        input = $('<input />').attr(
          type: 'checkbox'
          id: area_id
          name: 'contract[area_ids][]'
          value: this.id
        )
        label = $('<label>').attr(for: area_id).text(this.name)
        $("#select-areas-form").append(input).append(label)
      return
  return
