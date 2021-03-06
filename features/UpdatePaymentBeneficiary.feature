Feature: Update payment beneficiary
  As a user I want to update the payment beneficiary
  So that I can correct any mistake made at the creation time

  Background:
    Given that the following payment state(s) are stored in the table "events_transaction_stream"

      | event_id                             | event_name                     | metadata                                                                                                         | created_at | payload                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 8b3f0880-800c-40cf-9cc6-2d53be233c3f | transaction_payment_created_v0 | {"_aggregate_id": "71aa6f04-ede9-46f4-a63d-373c3c206fc1", "_aggregate_type": "Payment", "_aggregate_version": 1} | now        | {"id":"71aa6f04-ede9-46f4-a63d-373c3c206fc1","organisation_id":"743d5b63-8e6f-432e-a8fa-c5d8d2ee5fcb","attributes":{"amount":"100.21","beneficiary_party":{"name":"Wilfred Jeremiah Owens","address":"1 The Beneficiary Localtown SE2","bank_id":"403000","bank_id_code":"GBDSC","account_number":"31926819","account_name":"W Owens","account_number_code":"BBAN"},"charges_information":{"bearer_code":"SHAR","sender_charges":[{"amount":"5","currency":"GBP"},{"amount":"10","currency":"USD"}],"receiver_charges_amount":"1","receiver_charges_currency":"USD"},"currency":"GBP","debtor_party":{"name":"Emelia Jane Brown","address":"10 Debtor Crescent Sourcetown NE1","bank_id":"203301","bank_id_code":"GBDSC","account_number":"GB29XABC10161234567801","account_name":"EJ Brown Black","account_number_code":"IBAN"},"end_to_end_reference":"Wil piano Jan","fx":{"contract_reference":"FX123","exchange_rate":"2","original_amount":"200.42","original_currency":"USD"},"numeric_reference":"1002001","processing_date":"2017-01-18","reference":"Payment for Em's piano lessons","sponsor_party":{"bank_id":"123123","bank_id_code":"GBDSC","account_number":"56781234"},"payment_id":"123456789012345678","payment_purpose":"Paying for goods/services","payment_scheme":"FPS","payment_type":"Credit","scheme_payment_type":"ImmediatePayment","scheme_payment_sub_type":"InternetBanking"}} |

    And that the following payment(s) are stored in the table "transaction_payment"

      | id                                   | version | organisation_id                      | attributes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
      | 71aa6f04-ede9-46f4-a63d-373c3c206fc1 | 0       | 743d5b63-8e6f-432e-a8fa-c5d8d2ee5fcb | {"fx": {"exchange_rate": "2", "original_amount": "200.42", "original_currency": "USD", "contract_reference": "FX123"}, "amount": "100.21", "currency": "GBP", "reference": "Payment for Em's piano lessons", "payment_id": "123456789012345678", "debtor_party": {"name": "Emelia Jane Brown", "address": "10 Debtor Crescent Sourcetown NE1", "bank_id": "203301", "account_name": "EJ Brown Black", "bank_id_code": "GBDSC", "account_number": "GB29XABC10161234567801", "account_number_code": "IBAN"}, "payment_type": "Credit", "sponsor_party": {"bank_id": "123123", "bank_id_code": "GBDSC", "account_number": "56781234"}, "payment_scheme": "FPS", "payment_purpose": "Paying for goods/services", "processing_date": "2017-01-18", "beneficiary_party": {"name": "Wilfred Jeremiah Owens", "address": "1 The Beneficiary Localtown SE2", "bank_id": "403000", "account_name": "W Owens", "bank_id_code": "GBDSC", "account_number": "31926819", "account_number_code": "BBAN"}, "numeric_reference": "1002001", "charges_information": {"bearer_code": "SHAR", "sender_charges": [{"amount": "5", "currency": "GBP"}, {"amount": "10", "currency": "USD"}], "receiver_charges_amount": "1", "receiver_charges_currency": "USD"}, "scheme_payment_type": "ImmediatePayment", "end_to_end_reference": "Wil piano Jan", "scheme_payment_sub_type": "InternetBanking"} |

  Scenario: Payment's beneficiary should be updated
    When I request REST endpoint with method "PATCH" and path "/v1/transaction/payments/71aa6f04-ede9-46f4-a63d-373c3c206fc1/beneficiary" and body
    """
    {
      "account_name": "W Connor",
      "account_number": "31926812",
      "account_number_code": "BBAN",
      "account_type": 0,
      "address": "1 The Beneficiary Localtown SE2",
      "bank_id": "403000",
      "bank_id_code": "GBDSC",
      "name": "Wilfred Jeremiah Connor"
    }
    """

    Then I should have a no content response
    And the following payment(s) should be stored in the table "transaction_payment"

      | ID                                   | version | organisation_id                      | attributes                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      |
      | 71aa6f04-ede9-46f4-a63d-373c3c206fc1 | 0       | 743d5b63-8e6f-432e-a8fa-c5d8d2ee5fcb | {"fx": {"exchange_rate": "2", "original_amount": "200.42", "original_currency": "USD", "contract_reference": "FX123"}, "amount": "100.21", "currency": "GBP", "reference": "Payment for Em's piano lessons", "payment_id": "123456789012345678", "debtor_party": {"name": "Emelia Jane Brown", "address": "10 Debtor Crescent Sourcetown NE1", "bank_id": "203301", "account_name": "EJ Brown Black", "bank_id_code": "GBDSC", "account_number": "GB29XABC10161234567801", "account_number_code": "IBAN"}, "payment_type": "Credit", "sponsor_party": {"bank_id": "123123", "bank_id_code": "GBDSC", "account_number": "56781234"}, "payment_scheme": "FPS", "payment_purpose": "Paying for goods/services", "processing_date": "2017-01-18", "beneficiary_party": {"name": "Wilfred Jeremiah Connor", "address": "1 The Beneficiary Localtown SE2", "bank_id": "403000", "account_name": "W Connor", "bank_id_code": "GBDSC", "account_number": "31926812", "account_number_code": "BBAN"}, "numeric_reference": "1002001", "charges_information": {"bearer_code": "SHAR", "sender_charges": [{"amount": "5", "currency": "GBP"}, {"amount": "10", "currency": "USD"}], "receiver_charges_amount": "1", "receiver_charges_currency": "USD"}, "scheme_payment_type": "ImmediatePayment", "end_to_end_reference": "Wil piano Jan", "scheme_payment_sub_type": "InternetBanking"} |

    And the following payment state should be stored in the table "events_transaction_stream"

      | event_name                                 | metadata                                                                                                         |
      | transaction_payment_beneficiary_updated_v0 | {"_aggregate_id": "71aa6f04-ede9-46f4-a63d-373c3c206fc1", "_aggregate_type": "Payment", "_aggregate_version": 2} |

  Scenario: Payment's beneficiary should not be created account_name empty
    When I request REST endpoint with method "PATCH" and path "/v1/transaction/payments/71aa6f04-ede9-46f4-a63d-373c3c206fc1/beneficiary" and body
      """
    {
      "account_name": "",
      "account_number": "31926812",
      "account_number_code": "BBAN",
      "account_type": 0,
      "address": "1 The Beneficiary Localtown SE2",
      "bank_id": "403000",
      "bank_id_code": "GBDSC",
      "name": "Wilfred Jeremiah Connor"
    }
    """

    Then I should have a precondition failed response

  Scenario: Payment's beneficiary should be updated
    When I request REST endpoint with method "PATCH" and path "/v1/transaction/payments/1cd53ce8-88b9-4f02-aab8-fe848ec36716/beneficiary" and body
    """
    {
      "account_name": "W Connor",
      "account_number": "31926812",
      "account_number_code": "BBAN",
      "account_type": 0,
      "address": "1 The Beneficiary Localtown SE2",
      "bank_id": "403000",
      "bank_id_code": "GBDSC",
      "name": "Wilfred Jeremiah Connor"
    }
    """

    Then I should have a not found response