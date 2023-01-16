function register(data) {
    fetch('http://0.0.0.0:8080/api/v1/signun', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify(data),
})
.then((response) => response.json())
.then((data) => {
  console.log(data);
});
}


