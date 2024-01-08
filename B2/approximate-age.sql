SELECT FirstName, LastName, HireDate - BirthDate as ApproximateAge
From employees
ORDER BY ApproximateAge ASC