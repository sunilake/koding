package stripe

import (
	"errors"
	"fmt"
)

var (
	ErrPlanNotFound                    = errors.New("plan not available")
	ErrPlanAlreadyExists               = errors.New(`{"type":"invalid_request_error","message":"Plan already exists."}`)
	ErrCustomerNotFound                = errors.New("user not found")
	ErrCustomerAlreadySubscribedToPlan = errors.New("user is already subscribed to plan")
	ErrCustomerNotSubscribedToThatPlan = errors.New("user is not subscribed to that plan")
	ErrCustomerHasTooManySubscriptions = errors.New("user has too many subscriptions, should have only one")
	ErrCustomerNotSubscribedToAnyPlans = errors.New("user is not subscribed to any plans")
	ErrTokenIsEmpty                    = errors.New("token is required")

	ErrPlanNotFoundFn = func(planTitle string) string {
		return fmt.Sprintf(
			`pq: invalid input value for enum payment_plan_title: "%s"`, planTitle,
		)
	}
)
