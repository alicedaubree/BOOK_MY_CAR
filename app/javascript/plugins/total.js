const calctotal = () => {
  // First we define two variables that are going to grab our inputs field. You can check the ids of the inputs with the Chrome inspector.
  const startDateInput = document.getElementById('booking_start_date');
  const endDateInput = document.getElementById('booking_end_date');
  const unavailableDates = JSON.parse(document.querySelector('#car-booking-dates').dataset.unavailable)


  // Check that the query selector id matches the one you put around your form.
  if (startDateInput) {
  startDateInput.addEventListener("change", () => {
    if (endDateInput.value != "") {
      let pricePerDay = Number.parseInt(document.querySelector("#price_per_day").innerText)
      let days = (Date.parse(endDateInput.value) - Date.parse(startDateInput.value)) / (1000*60*60*24)
      if (days <= 0) {
        document.querySelector('#booking-infos').innerHTML = '<p class="text-center my-3">End date must be after start date</p>'
        document.querySelector('#submit-button').disabled = true
      } else if (dateOverlap(unavailableDates, startDateInput.value, endDateInput.value)){
        document.querySelector('#booking-infos').innerHTML = '<p class="text-center my-3">These dates are not available</p>'
        document.querySelector('#submit-button').disabled = true
      } else {
        document.querySelector('#booking-infos').innerHTML = `<div class="booking-infos-style my-3"><p class="text-center my-3">Booking from <em>${startDateInput.value}</em> to <em>${endDateInput.value}</em><p><p class="text-center my-3">${days} days</p><p class="text-center my-3"><strong>Total price: $${days*pricePerDay}</strong></p></div>`
        document.querySelector('#submit-button').disabled = false
      }
    }
  })
  endDateInput.addEventListener("change", () => {
    if (startDateInput.value != "") {
      let pricePerDay = Number.parseInt(document.querySelector("#price_per_day").innerText)
      let days = (Date.parse(endDateInput.value) - Date.parse(startDateInput.value)) / (1000*60*60*24)
      if (days <= 0) {
        document.querySelector('#booking-infos').innerHTML = '<p class="text-center my-3">End date must be after start date</p>'
        document.querySelector('#submit-button').disabled = true
      } else if (dateOverlap(unavailableDates, startDateInput.value, endDateInput.value)){
        document.querySelector('#booking-infos').innerHTML = '<p class="text-center my-3">These dates are not available</p>'
        document.querySelector('#submit-button').disabled = true
      } else {
        document.querySelector('#booking-infos').innerHTML = `<div class="booking-infos-style my-3"><p class="text-center my-3">Booking from <em>${startDateInput.value}</em> to <em>${endDateInput.value}</em><p><p class="text-center my-3">${days} days</p><p class="text-center my-3"><strong>Total price: $${days*pricePerDay}</strong></p></div>`
        document.querySelector('#submit-button').disabled = false
      }
    }
  })
  };
}

const dateOverlap = (unavailable, start, end) => {
  let overlap = false
  unavailable.forEach((range) => {
    if (dateBetween(start, end, range.from) || dateBetween(start, end, range.to)) {
      console.log("overlapping")
      overlap = true
    }
  })
  return overlap
}

const dateBetween = (from, to, check) => {
  let fDate,lDate,cDate;
  fDate = Date.parse(from);
  lDate = Date.parse(to);
  cDate = Date.parse(check);
  if((cDate <= lDate && cDate >= fDate))  return true
  return false;
}

export { calctotal };
