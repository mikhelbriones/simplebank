package util

const (
	USD = "USD"
	EUR = "EUR"
	CAD = "CAD"
	PHP = "PHP"
)

func IsSupportedCurrency(currency string) bool {
	switch currency {
	case USD, EUR, CAD, PHP:
		return true
	}
	return false
}
