package j_account

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"net/http"
	"time"

	"golang.org/x/net/context"

	"github.com/go-openapi/errors"
	"github.com/go-openapi/runtime"
	cr "github.com/go-openapi/runtime/client"

	strfmt "github.com/go-openapi/strfmt"

	"koding/remoteapi/models"
)

// NewPostRemoteAPIJAccountUpdateFlagsIDParams creates a new PostRemoteAPIJAccountUpdateFlagsIDParams object
// with the default values initialized.
func NewPostRemoteAPIJAccountUpdateFlagsIDParams() *PostRemoteAPIJAccountUpdateFlagsIDParams {
	var ()
	return &PostRemoteAPIJAccountUpdateFlagsIDParams{

		timeout: cr.DefaultTimeout,
	}
}

// NewPostRemoteAPIJAccountUpdateFlagsIDParamsWithTimeout creates a new PostRemoteAPIJAccountUpdateFlagsIDParams object
// with the default values initialized, and the ability to set a timeout on a request
func NewPostRemoteAPIJAccountUpdateFlagsIDParamsWithTimeout(timeout time.Duration) *PostRemoteAPIJAccountUpdateFlagsIDParams {
	var ()
	return &PostRemoteAPIJAccountUpdateFlagsIDParams{

		timeout: timeout,
	}
}

// NewPostRemoteAPIJAccountUpdateFlagsIDParamsWithContext creates a new PostRemoteAPIJAccountUpdateFlagsIDParams object
// with the default values initialized, and the ability to set a context for a request
func NewPostRemoteAPIJAccountUpdateFlagsIDParamsWithContext(ctx context.Context) *PostRemoteAPIJAccountUpdateFlagsIDParams {
	var ()
	return &PostRemoteAPIJAccountUpdateFlagsIDParams{

		Context: ctx,
	}
}

/*PostRemoteAPIJAccountUpdateFlagsIDParams contains all the parameters to send to the API endpoint
for the post remote API j account update flags ID operation typically these are written to a http.Request
*/
type PostRemoteAPIJAccountUpdateFlagsIDParams struct {

	/*Body
	  body of the request

	*/
	Body models.DefaultSelector
	/*ID
	  Mongo ID of target instance

	*/
	ID string

	timeout    time.Duration
	Context    context.Context
	HTTPClient *http.Client
}

// WithTimeout adds the timeout to the post remote API j account update flags ID params
func (o *PostRemoteAPIJAccountUpdateFlagsIDParams) WithTimeout(timeout time.Duration) *PostRemoteAPIJAccountUpdateFlagsIDParams {
	o.SetTimeout(timeout)
	return o
}

// SetTimeout adds the timeout to the post remote API j account update flags ID params
func (o *PostRemoteAPIJAccountUpdateFlagsIDParams) SetTimeout(timeout time.Duration) {
	o.timeout = timeout
}

// WithContext adds the context to the post remote API j account update flags ID params
func (o *PostRemoteAPIJAccountUpdateFlagsIDParams) WithContext(ctx context.Context) *PostRemoteAPIJAccountUpdateFlagsIDParams {
	o.SetContext(ctx)
	return o
}

// SetContext adds the context to the post remote API j account update flags ID params
func (o *PostRemoteAPIJAccountUpdateFlagsIDParams) SetContext(ctx context.Context) {
	o.Context = ctx
}

// WithBody adds the body to the post remote API j account update flags ID params
func (o *PostRemoteAPIJAccountUpdateFlagsIDParams) WithBody(body models.DefaultSelector) *PostRemoteAPIJAccountUpdateFlagsIDParams {
	o.SetBody(body)
	return o
}

// SetBody adds the body to the post remote API j account update flags ID params
func (o *PostRemoteAPIJAccountUpdateFlagsIDParams) SetBody(body models.DefaultSelector) {
	o.Body = body
}

// WithID adds the id to the post remote API j account update flags ID params
func (o *PostRemoteAPIJAccountUpdateFlagsIDParams) WithID(id string) *PostRemoteAPIJAccountUpdateFlagsIDParams {
	o.SetID(id)
	return o
}

// SetID adds the id to the post remote API j account update flags ID params
func (o *PostRemoteAPIJAccountUpdateFlagsIDParams) SetID(id string) {
	o.ID = id
}

// WriteToRequest writes these params to a swagger request
func (o *PostRemoteAPIJAccountUpdateFlagsIDParams) WriteToRequest(r runtime.ClientRequest, reg strfmt.Registry) error {

	r.SetTimeout(o.timeout)
	var res []error

	if err := r.SetBodyParam(o.Body); err != nil {
		return err
	}

	// path param id
	if err := r.SetPathParam("id", o.ID); err != nil {
		return err
	}

	if len(res) > 0 {
		return errors.CompositeValidationError(res...)
	}
	return nil
}
