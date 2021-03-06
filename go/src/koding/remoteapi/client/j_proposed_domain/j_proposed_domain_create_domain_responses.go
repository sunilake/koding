package j_proposed_domain

// This file was generated by the swagger tool.
// Editing this file might prove futile when you re-run the swagger generate command

import (
	"fmt"
	"io"

	"github.com/go-openapi/runtime"

	strfmt "github.com/go-openapi/strfmt"

	"koding/remoteapi/models"
)

// JProposedDomainCreateDomainReader is a Reader for the JProposedDomainCreateDomain structure.
type JProposedDomainCreateDomainReader struct {
	formats strfmt.Registry
}

// ReadResponse reads a server response into the received o.
func (o *JProposedDomainCreateDomainReader) ReadResponse(response runtime.ClientResponse, consumer runtime.Consumer) (interface{}, error) {
	switch response.Code() {

	case 200:
		result := NewJProposedDomainCreateDomainOK()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return result, nil

	case 401:
		result := NewJProposedDomainCreateDomainUnauthorized()
		if err := result.readResponse(response, consumer, o.formats); err != nil {
			return nil, err
		}
		return nil, result

	default:
		return nil, runtime.NewAPIError("unknown error", response, response.Code())
	}
}

// NewJProposedDomainCreateDomainOK creates a JProposedDomainCreateDomainOK with default headers values
func NewJProposedDomainCreateDomainOK() *JProposedDomainCreateDomainOK {
	return &JProposedDomainCreateDomainOK{}
}

/*JProposedDomainCreateDomainOK handles this case with default header values.

Request processed successfully
*/
type JProposedDomainCreateDomainOK struct {
	Payload *models.DefaultResponse
}

func (o *JProposedDomainCreateDomainOK) Error() string {
	return fmt.Sprintf("[POST /remote.api/JProposedDomain.createDomain][%d] jProposedDomainCreateDomainOK  %+v", 200, o.Payload)
}

func (o *JProposedDomainCreateDomainOK) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.DefaultResponse)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}

// NewJProposedDomainCreateDomainUnauthorized creates a JProposedDomainCreateDomainUnauthorized with default headers values
func NewJProposedDomainCreateDomainUnauthorized() *JProposedDomainCreateDomainUnauthorized {
	return &JProposedDomainCreateDomainUnauthorized{}
}

/*JProposedDomainCreateDomainUnauthorized handles this case with default header values.

Unauthorized request
*/
type JProposedDomainCreateDomainUnauthorized struct {
	Payload *models.UnauthorizedRequest
}

func (o *JProposedDomainCreateDomainUnauthorized) Error() string {
	return fmt.Sprintf("[POST /remote.api/JProposedDomain.createDomain][%d] jProposedDomainCreateDomainUnauthorized  %+v", 401, o.Payload)
}

func (o *JProposedDomainCreateDomainUnauthorized) readResponse(response runtime.ClientResponse, consumer runtime.Consumer, formats strfmt.Registry) error {

	o.Payload = new(models.UnauthorizedRequest)

	// response payload
	if err := consumer.Consume(response.Body(), o.Payload); err != nil && err != io.EOF {
		return err
	}

	return nil
}
