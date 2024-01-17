// ignore_for_file: public_member_api_docs

import 'package:flutter_pjsip/bindings/bindings.dart';

/// This enumeration lists standard SIP status codes according to RFC 3261.
/// In addition, it also declares new status class 7xx for errors generated
/// by the stack. This status class however should not get transmitted on the
/// wire.
enum PjsipStatusCode {
  isNull(code: pjsip_status_code.PJSIP_SC_NULL),
  trying(code: pjsip_status_code.PJSIP_SC_TRYING),
  ringing(code: pjsip_status_code.PJSIP_SC_RINGING),
  callBeingForwarded(code: pjsip_status_code.PJSIP_SC_CALL_BEING_FORWARDED),
  queued(code: pjsip_status_code.PJSIP_SC_QUEUED),
  progress(code: pjsip_status_code.PJSIP_SC_PROGRESS),
  earlyDialogTerminated(
    code: pjsip_status_code.PJSIP_SC_EARLY_DIALOG_TERMINATED,
  ),

  ok(code: pjsip_status_code.PJSIP_SC_OK),
  accepted(code: pjsip_status_code.PJSIP_SC_ACCEPTED),
  noNotification(code: pjsip_status_code.PJSIP_SC_NO_NOTIFICATION),

  multipleChoices(code: pjsip_status_code.PJSIP_SC_MULTIPLE_CHOICES),
  movedPermanently(code: pjsip_status_code.PJSIP_SC_MOVED_PERMANENTLY),
  movedTemporarily(code: pjsip_status_code.PJSIP_SC_MOVED_TEMPORARILY),
  useProxy(code: pjsip_status_code.PJSIP_SC_USE_PROXY),
  alternativeService(code: pjsip_status_code.PJSIP_SC_ALTERNATIVE_SERVICE),

  badRequest(code: pjsip_status_code.PJSIP_SC_BAD_REQUEST),
  unauthorized(code: pjsip_status_code.PJSIP_SC_UNAUTHORIZED),
  paymentRequired(code: pjsip_status_code.PJSIP_SC_PAYMENT_REQUIRED),
  forbidden(code: pjsip_status_code.PJSIP_SC_FORBIDDEN),
  notFound(code: pjsip_status_code.PJSIP_SC_NOT_FOUND),
  methodNotAllowed(code: pjsip_status_code.PJSIP_SC_METHOD_NOT_ALLOWED),
  notAcceptable(code: pjsip_status_code.PJSIP_SC_NOT_ACCEPTABLE),
  proxyAuthenticationRequired(
    code: pjsip_status_code.PJSIP_SC_PROXY_AUTHENTICATION_REQUIRED,
  ),
  requestTimeout(code: pjsip_status_code.PJSIP_SC_REQUEST_TIMEOUT),
  conflict(code: pjsip_status_code.PJSIP_SC_CONFLICT),
  gone(code: pjsip_status_code.PJSIP_SC_GONE),
  lengthRequired(code: pjsip_status_code.PJSIP_SC_LENGTH_REQUIRED),
  conditionalRequestFailed(
    code: pjsip_status_code.PJSIP_SC_CONDITIONAL_REQUEST_FAILED,
  ),
  requestEntityTooLarge(
    code: pjsip_status_code.PJSIP_SC_REQUEST_ENTITY_TOO_LARGE,
  ),
  requestUriTooLong(code: pjsip_status_code.PJSIP_SC_REQUEST_URI_TOO_LONG),
  unsupportedMediaType(code: pjsip_status_code.PJSIP_SC_UNSUPPORTED_MEDIA_TYPE),
  unsupportedUriScheme(code: pjsip_status_code.PJSIP_SC_UNSUPPORTED_URI_SCHEME),
  unknownResourcePriority(
    code: pjsip_status_code.PJSIP_SC_UNKNOWN_RESOURCE_PRIORITY,
  ),
  badExtension(code: pjsip_status_code.PJSIP_SC_BAD_EXTENSION),
  extensionRequired(code: pjsip_status_code.PJSIP_SC_EXTENSION_REQUIRED),
  sessionTimerTooSmall(
    code: pjsip_status_code.PJSIP_SC_SESSION_TIMER_TOO_SMALL,
  ),
  intervalTooBrief(code: pjsip_status_code.PJSIP_SC_INTERVAL_TOO_BRIEF),
  badLocationInformation(
    code: pjsip_status_code.PJSIP_SC_BAD_LOCATION_INFORMATION,
  ),
  useIdentityHeader(code: pjsip_status_code.PJSIP_SC_USE_IDENTITY_HEADER),
  provideReferrerHeader(
    code: pjsip_status_code.PJSIP_SC_PROVIDE_REFERRER_HEADER,
  ),
  flowFailed(code: pjsip_status_code.PJSIP_SC_FLOW_FAILED),
  anonymityDisallowed(code: pjsip_status_code.PJSIP_SC_ANONIMITY_DISALLOWED),
  badIdentityInfo(code: pjsip_status_code.PJSIP_SC_BAD_IDENTITY_INFO),
  unsupportedCertificate(
    code: pjsip_status_code.PJSIP_SC_UNSUPPORTED_CERTIFICATE,
  ),
  invalidIdentityHeader(
    code: pjsip_status_code.PJSIP_SC_INVALID_IDENTITY_HEADER,
  ),
  firstHopLacksOutboundSupport(
    code: pjsip_status_code.PJSIP_SC_FIRST_HOP_LACKS_OUTBOUND_SUPPORT,
  ),
  maxBreadthExceeded(code: pjsip_status_code.PJSIP_SC_MAX_BREADTH_EXCEEDED),
  badInfoPackage(code: pjsip_status_code.PJSIP_SC_BAD_INFO_PACKAGE),
  consentNeeded(code: pjsip_status_code.PJSIP_SC_CONSENT_NEEDED),
  temporarilyUnavailable(
    code: pjsip_status_code.PJSIP_SC_TEMPORARILY_UNAVAILABLE,
  ),
  callTsxDoesNotExist(code: pjsip_status_code.PJSIP_SC_CALL_TSX_DOES_NOT_EXIST),
  loopDetected(code: pjsip_status_code.PJSIP_SC_LOOP_DETECTED),
  tooManyHops(code: pjsip_status_code.PJSIP_SC_TOO_MANY_HOPS),
  addressIncomplete(code: pjsip_status_code.PJSIP_SC_ADDRESS_INCOMPLETE),
  ambiguous(code: pjsip_status_code.PJSIP_AC_AMBIGUOUS),
  busyHere(code: pjsip_status_code.PJSIP_SC_BUSY_HERE),
  requestTerminated(code: pjsip_status_code.PJSIP_SC_REQUEST_TERMINATED),
  notAcceptableHere(code: pjsip_status_code.PJSIP_SC_NOT_ACCEPTABLE_HERE),
  badEvent(code: pjsip_status_code.PJSIP_SC_BAD_EVENT),
  requestUpdated(code: pjsip_status_code.PJSIP_SC_REQUEST_UPDATED),
  requestPending(code: pjsip_status_code.PJSIP_SC_REQUEST_PENDING),
  undecipherable(code: pjsip_status_code.PJSIP_SC_UNDECIPHERABLE),
  securityAgreementNeeded(
    code: pjsip_status_code.PJSIP_SC_SECURITY_AGREEMENT_NEEDED,
  ),

  internalServerError(code: pjsip_status_code.PJSIP_SC_INTERNAL_SERVER_ERROR),
  notImplemented(code: pjsip_status_code.PJSIP_SC_NOT_IMPLEMENTED),
  badGateway(code: pjsip_status_code.PJSIP_SC_BAD_GATEWAY),
  serviceUnavailable(code: pjsip_status_code.PJSIP_SC_SERVICE_UNAVAILABLE),
  serverTimeout(code: pjsip_status_code.PJSIP_SC_SERVER_TIMEOUT),
  versionNotSupported(code: pjsip_status_code.PJSIP_SC_VERSION_NOT_SUPPORTED),
  messageTooLarge(code: pjsip_status_code.PJSIP_SC_MESSAGE_TOO_LARGE),
  pushNotificationServiceNotSupported(
    code: pjsip_status_code.PJSIP_SC_PUSH_NOTIFICATION_SERVICE_NOT_SUPPORTED,
  ),
  preconditionFailure(code: pjsip_status_code.PJSIP_SC_PRECONDITION_FAILURE),

  busyEverywhere(code: pjsip_status_code.PJSIP_SC_BUSY_EVERYWHERE),
  decline(code: pjsip_status_code.PJSIP_SC_DECLINE),
  doesNotExistAnywhere(
    code: pjsip_status_code.PJSIP_SC_DOES_NOT_EXIST_ANYWHERE,
  ),
  notAcceptableAnywhere(
    code: pjsip_status_code.PJSIP_SC_NOT_ACCEPTABLE_ANYWHERE,
  ),
  unwanted(code: pjsip_status_code.PJSIP_SC_UNWANTED),
  rejected(code: pjsip_status_code.PJSIP_SC_REJECTED),

  tsxTimeout(code: pjsip_status_code.PJSIP_SC_TSX_TIMEOUT),
  tsxTransportError(code: pjsip_status_code.PJSIP_SC_TSX_TRANSPORT_ERROR),
  tsxResolvError(code: 702);

  const PjsipStatusCode({required this.code});

  /// The status code.
  final int code;

  /// Convert from a native pjsip_status_code to a PjsipStatusCode
  static PjsipStatusCode fromInt(int cls) {
    switch (cls) {
      case pjsip_status_code.PJSIP_SC_NULL:
        return isNull;
      case pjsip_status_code.PJSIP_SC_TRYING:
        return trying;
      case pjsip_status_code.PJSIP_SC_RINGING:
        return ringing;
      case pjsip_status_code.PJSIP_SC_CALL_BEING_FORWARDED:
        return callBeingForwarded;
      case pjsip_status_code.PJSIP_SC_QUEUED:
        return queued;
      case pjsip_status_code.PJSIP_SC_PROGRESS:
        return progress;
      case pjsip_status_code.PJSIP_SC_EARLY_DIALOG_TERMINATED:
        return earlyDialogTerminated;
      case pjsip_status_code.PJSIP_SC_OK:
        return ok;
      case pjsip_status_code.PJSIP_SC_ACCEPTED:
        return accepted;
      case pjsip_status_code.PJSIP_SC_NO_NOTIFICATION:
        return noNotification;
      case pjsip_status_code.PJSIP_SC_MULTIPLE_CHOICES:
        return multipleChoices;
      case pjsip_status_code.PJSIP_SC_MOVED_PERMANENTLY:
        return movedPermanently;
      case pjsip_status_code.PJSIP_SC_MOVED_TEMPORARILY:
        return movedTemporarily;
      case pjsip_status_code.PJSIP_SC_USE_PROXY:
        return useProxy;
      case pjsip_status_code.PJSIP_SC_ALTERNATIVE_SERVICE:
        return alternativeService;
      case pjsip_status_code.PJSIP_SC_BAD_REQUEST:
        return badRequest;
      case pjsip_status_code.PJSIP_SC_UNAUTHORIZED:
        return unauthorized;
      case pjsip_status_code.PJSIP_SC_PAYMENT_REQUIRED:
        return paymentRequired;
      case pjsip_status_code.PJSIP_SC_FORBIDDEN:
        return forbidden;
      case pjsip_status_code.PJSIP_SC_NOT_FOUND:
        return notFound;
      case pjsip_status_code.PJSIP_SC_METHOD_NOT_ALLOWED:
        return methodNotAllowed;
      case pjsip_status_code.PJSIP_SC_NOT_ACCEPTABLE:
        return notAcceptable;
      case pjsip_status_code.PJSIP_SC_PROXY_AUTHENTICATION_REQUIRED:
        return proxyAuthenticationRequired;
      case pjsip_status_code.PJSIP_SC_REQUEST_TIMEOUT:
        return requestTimeout;
      case pjsip_status_code.PJSIP_SC_CONFLICT:
        return conflict;
      case pjsip_status_code.PJSIP_SC_GONE:
        return gone;
      case pjsip_status_code.PJSIP_SC_LENGTH_REQUIRED:
        return lengthRequired;
      case pjsip_status_code.PJSIP_SC_CONDITIONAL_REQUEST_FAILED:
        return conditionalRequestFailed;
      case pjsip_status_code.PJSIP_SC_REQUEST_ENTITY_TOO_LARGE:
        return requestEntityTooLarge;
      case pjsip_status_code.PJSIP_SC_REQUEST_URI_TOO_LONG:
        return requestUriTooLong;
      case pjsip_status_code.PJSIP_SC_UNSUPPORTED_MEDIA_TYPE:
        return unsupportedMediaType;
      case pjsip_status_code.PJSIP_SC_UNSUPPORTED_URI_SCHEME:
        return unsupportedUriScheme;
      case pjsip_status_code.PJSIP_SC_UNKNOWN_RESOURCE_PRIORITY:
        return unknownResourcePriority;
      case pjsip_status_code.PJSIP_SC_BAD_EXTENSION:
        return badExtension;
      case pjsip_status_code.PJSIP_SC_EXTENSION_REQUIRED:
        return extensionRequired;
      case pjsip_status_code.PJSIP_SC_SESSION_TIMER_TOO_SMALL:
        return sessionTimerTooSmall;
      case pjsip_status_code.PJSIP_SC_INTERVAL_TOO_BRIEF:
        return intervalTooBrief;
      case pjsip_status_code.PJSIP_SC_BAD_LOCATION_INFORMATION:
        return badLocationInformation;
      case pjsip_status_code.PJSIP_SC_USE_IDENTITY_HEADER:
        return useIdentityHeader;
      case pjsip_status_code.PJSIP_SC_PROVIDE_REFERRER_HEADER:
        return provideReferrerHeader;
      case pjsip_status_code.PJSIP_SC_FLOW_FAILED:
        return flowFailed;
      case pjsip_status_code.PJSIP_SC_ANONIMITY_DISALLOWED:
        return anonymityDisallowed;
      case pjsip_status_code.PJSIP_SC_BAD_IDENTITY_INFO:
        return badIdentityInfo;
      case pjsip_status_code.PJSIP_SC_UNSUPPORTED_CERTIFICATE:
        return unsupportedCertificate;
      case pjsip_status_code.PJSIP_SC_INVALID_IDENTITY_HEADER:
        return invalidIdentityHeader;
      case pjsip_status_code.PJSIP_SC_FIRST_HOP_LACKS_OUTBOUND_SUPPORT:
        return firstHopLacksOutboundSupport;
      case pjsip_status_code.PJSIP_SC_MAX_BREADTH_EXCEEDED:
        return maxBreadthExceeded;
      case pjsip_status_code.PJSIP_SC_BAD_INFO_PACKAGE:
        return badInfoPackage;
      case pjsip_status_code.PJSIP_SC_CONSENT_NEEDED:
        return consentNeeded;
      case pjsip_status_code.PJSIP_SC_TEMPORARILY_UNAVAILABLE:
        return temporarilyUnavailable;
      case pjsip_status_code.PJSIP_SC_CALL_TSX_DOES_NOT_EXIST:
        return callTsxDoesNotExist;
      case pjsip_status_code.PJSIP_SC_LOOP_DETECTED:
        return loopDetected;
      case pjsip_status_code.PJSIP_SC_TOO_MANY_HOPS:
        return tooManyHops;
      case pjsip_status_code.PJSIP_SC_ADDRESS_INCOMPLETE:
        return addressIncomplete;
      case pjsip_status_code.PJSIP_AC_AMBIGUOUS:
        return ambiguous;
      case pjsip_status_code.PJSIP_SC_BUSY_HERE:
        return busyHere;
      case pjsip_status_code.PJSIP_SC_REQUEST_TERMINATED:
        return requestTerminated;
      case pjsip_status_code.PJSIP_SC_NOT_ACCEPTABLE_HERE:
        return notAcceptableHere;
      case pjsip_status_code.PJSIP_SC_BAD_EVENT:
        return badEvent;
      case pjsip_status_code.PJSIP_SC_REQUEST_UPDATED:
        return requestUpdated;
      case pjsip_status_code.PJSIP_SC_REQUEST_PENDING:
        return requestPending;
      case pjsip_status_code.PJSIP_SC_UNDECIPHERABLE:
        return undecipherable;
      case pjsip_status_code.PJSIP_SC_SECURITY_AGREEMENT_NEEDED:
        return securityAgreementNeeded;
      case pjsip_status_code.PJSIP_SC_INTERNAL_SERVER_ERROR:
        return internalServerError;
      case pjsip_status_code.PJSIP_SC_NOT_IMPLEMENTED:
        return notImplemented;
      case pjsip_status_code.PJSIP_SC_BAD_GATEWAY:
        return badGateway;
      case pjsip_status_code.PJSIP_SC_SERVICE_UNAVAILABLE:
        return serviceUnavailable;
      case pjsip_status_code.PJSIP_SC_SERVER_TIMEOUT:
        return serverTimeout;
      case pjsip_status_code.PJSIP_SC_VERSION_NOT_SUPPORTED:
        return versionNotSupported;
      case pjsip_status_code.PJSIP_SC_MESSAGE_TOO_LARGE:
        return messageTooLarge;
      case pjsip_status_code.PJSIP_SC_PUSH_NOTIFICATION_SERVICE_NOT_SUPPORTED:
        return pushNotificationServiceNotSupported;
      case pjsip_status_code.PJSIP_SC_PRECONDITION_FAILURE:
        return preconditionFailure;
      case pjsip_status_code.PJSIP_SC_BUSY_EVERYWHERE:
        return busyEverywhere;
      case pjsip_status_code.PJSIP_SC_DECLINE:
        return decline;
      case pjsip_status_code.PJSIP_SC_DOES_NOT_EXIST_ANYWHERE:
        return doesNotExistAnywhere;
      case pjsip_status_code.PJSIP_SC_NOT_ACCEPTABLE_ANYWHERE:
        return notAcceptableAnywhere;
      case pjsip_status_code.PJSIP_SC_UNWANTED:
        return unwanted;
      case pjsip_status_code.PJSIP_SC_REJECTED:
        return rejected;
      // same with PJSIP_SC_REQUEST_TIMEOUT
      // case pjsip_status_code.PJSIP_SC_TSX_TIMEOUT:
      // return tsxTimeout;
      // same with PJSIP_SC_SERVICE_UNAVAILABLE
      // case pjsip_status_code.PJSIP_SC_TSX_TRANSPORT_ERROR:
      // return tsxTransportError;
      case 702:
        return tsxResolvError;
      default:
        throw Exception('Unknown pjsip_status_code: $cls');
    }
  }

  /// Convert from a PjsipStatusCode to a native pjsip_status_code
  int toInt() {
    switch (this) {
      case isNull:
        return pjsip_status_code.PJSIP_SC_NULL;
      case trying:
        return pjsip_status_code.PJSIP_SC_TRYING;
      case ringing:
        return pjsip_status_code.PJSIP_SC_RINGING;
      case callBeingForwarded:
        return pjsip_status_code.PJSIP_SC_CALL_BEING_FORWARDED;
      case queued:
        return pjsip_status_code.PJSIP_SC_QUEUED;
      case progress:
        return pjsip_status_code.PJSIP_SC_PROGRESS;
      case earlyDialogTerminated:
        return pjsip_status_code.PJSIP_SC_EARLY_DIALOG_TERMINATED;
      case ok:
        return pjsip_status_code.PJSIP_SC_OK;
      case accepted:
        return pjsip_status_code.PJSIP_SC_ACCEPTED;
      case noNotification:
        return pjsip_status_code.PJSIP_SC_NO_NOTIFICATION;
      case multipleChoices:
        return pjsip_status_code.PJSIP_SC_MULTIPLE_CHOICES;
      case movedPermanently:
        return pjsip_status_code.PJSIP_SC_MOVED_PERMANENTLY;
      case movedTemporarily:
        return pjsip_status_code.PJSIP_SC_MOVED_TEMPORARILY;
      case useProxy:
        return pjsip_status_code.PJSIP_SC_USE_PROXY;
      case alternativeService:
        return pjsip_status_code.PJSIP_SC_ALTERNATIVE_SERVICE;
      case badRequest:
        return pjsip_status_code.PJSIP_SC_BAD_REQUEST;
      case unauthorized:
        return pjsip_status_code.PJSIP_SC_UNAUTHORIZED;
      case paymentRequired:
        return pjsip_status_code.PJSIP_SC_PAYMENT_REQUIRED;
      case forbidden:
        return pjsip_status_code.PJSIP_SC_FORBIDDEN;
      case notFound:
        return pjsip_status_code.PJSIP_SC_NOT_FOUND;
      case methodNotAllowed:
        return pjsip_status_code.PJSIP_SC_METHOD_NOT_ALLOWED;
      case notAcceptable:
        return pjsip_status_code.PJSIP_SC_NOT_ACCEPTABLE;
      case proxyAuthenticationRequired:
        return pjsip_status_code.PJSIP_SC_PROXY_AUTHENTICATION_REQUIRED;
      case requestTimeout:
        return pjsip_status_code.PJSIP_SC_REQUEST_TIMEOUT;
      case conflict:
        return pjsip_status_code.PJSIP_SC_CONFLICT;
      case gone:
        return pjsip_status_code.PJSIP_SC_GONE;
      case lengthRequired:
        return pjsip_status_code.PJSIP_SC_LENGTH_REQUIRED;
      case conditionalRequestFailed:
        return pjsip_status_code.PJSIP_SC_CONDITIONAL_REQUEST_FAILED;
      case requestEntityTooLarge:
        return pjsip_status_code.PJSIP_SC_REQUEST_ENTITY_TOO_LARGE;
      case requestUriTooLong:
        return pjsip_status_code.PJSIP_SC_REQUEST_URI_TOO_LONG;
      case unsupportedMediaType:
        return pjsip_status_code.PJSIP_SC_UNSUPPORTED_MEDIA_TYPE;
      case unsupportedUriScheme:
        return pjsip_status_code.PJSIP_SC_UNSUPPORTED_URI_SCHEME;
      case unknownResourcePriority:
        return pjsip_status_code.PJSIP_SC_UNKNOWN_RESOURCE_PRIORITY;
      case badExtension:
        return pjsip_status_code.PJSIP_SC_BAD_EXTENSION;
      case extensionRequired:
        return pjsip_status_code.PJSIP_SC_EXTENSION_REQUIRED;
      case sessionTimerTooSmall:
        return pjsip_status_code.PJSIP_SC_SESSION_TIMER_TOO_SMALL;
      case intervalTooBrief:
        return pjsip_status_code.PJSIP_SC_INTERVAL_TOO_BRIEF;
      case badLocationInformation:
        return pjsip_status_code.PJSIP_SC_BAD_LOCATION_INFORMATION;
      case useIdentityHeader:
        return pjsip_status_code.PJSIP_SC_USE_IDENTITY_HEADER;
      case provideReferrerHeader:
        return pjsip_status_code.PJSIP_SC_PROVIDE_REFERRER_HEADER;
      case flowFailed:
        return pjsip_status_code.PJSIP_SC_FLOW_FAILED;
      case anonymityDisallowed:
        return pjsip_status_code.PJSIP_SC_ANONIMITY_DISALLOWED;
      case badIdentityInfo:
        return pjsip_status_code.PJSIP_SC_BAD_IDENTITY_INFO;
      case unsupportedCertificate:
        return pjsip_status_code.PJSIP_SC_UNSUPPORTED_CERTIFICATE;
      case invalidIdentityHeader:
        return pjsip_status_code.PJSIP_SC_INVALID_IDENTITY_HEADER;
      case firstHopLacksOutboundSupport:
        return pjsip_status_code.PJSIP_SC_FIRST_HOP_LACKS_OUTBOUND_SUPPORT;
      case maxBreadthExceeded:
        return pjsip_status_code.PJSIP_SC_MAX_BREADTH_EXCEEDED;
      case badInfoPackage:
        return pjsip_status_code.PJSIP_SC_BAD_INFO_PACKAGE;
      case consentNeeded:
        return pjsip_status_code.PJSIP_SC_CONSENT_NEEDED;
      case temporarilyUnavailable:
        return pjsip_status_code.PJSIP_SC_TEMPORARILY_UNAVAILABLE;
      case callTsxDoesNotExist:
        return pjsip_status_code.PJSIP_SC_CALL_TSX_DOES_NOT_EXIST;
      case loopDetected:
        return pjsip_status_code.PJSIP_SC_LOOP_DETECTED;
      case tooManyHops:
        return pjsip_status_code.PJSIP_SC_TOO_MANY_HOPS;
      case addressIncomplete:
        return pjsip_status_code.PJSIP_SC_ADDRESS_INCOMPLETE;
      case ambiguous:
        return pjsip_status_code.PJSIP_AC_AMBIGUOUS;
      case busyHere:
        return pjsip_status_code.PJSIP_SC_BUSY_HERE;
      case requestTerminated:
        return pjsip_status_code.PJSIP_SC_REQUEST_TERMINATED;
      case notAcceptableHere:
        return pjsip_status_code.PJSIP_SC_NOT_ACCEPTABLE_HERE;
      case badEvent:
        return pjsip_status_code.PJSIP_SC_BAD_EVENT;
      case requestUpdated:
        return pjsip_status_code.PJSIP_SC_REQUEST_UPDATED;
      case requestPending:
        return pjsip_status_code.PJSIP_SC_REQUEST_PENDING;
      case undecipherable:
        return pjsip_status_code.PJSIP_SC_UNDECIPHERABLE;
      case securityAgreementNeeded:
        return pjsip_status_code.PJSIP_SC_SECURITY_AGREEMENT_NEEDED;
      case internalServerError:
        return pjsip_status_code.PJSIP_SC_INTERNAL_SERVER_ERROR;
      case notImplemented:
        return pjsip_status_code.PJSIP_SC_NOT_IMPLEMENTED;
      case badGateway:
        return pjsip_status_code.PJSIP_SC_BAD_GATEWAY;
      case serviceUnavailable:
        return pjsip_status_code.PJSIP_SC_SERVICE_UNAVAILABLE;
      case serverTimeout:
        return pjsip_status_code.PJSIP_SC_SERVER_TIMEOUT;
      case versionNotSupported:
        return pjsip_status_code.PJSIP_SC_VERSION_NOT_SUPPORTED;
      case messageTooLarge:
        return pjsip_status_code.PJSIP_SC_MESSAGE_TOO_LARGE;
      case pushNotificationServiceNotSupported:
        return pjsip_status_code
            .PJSIP_SC_PUSH_NOTIFICATION_SERVICE_NOT_SUPPORTED;
      case preconditionFailure:
        return pjsip_status_code.PJSIP_SC_PRECONDITION_FAILURE;
      case busyEverywhere:
        return pjsip_status_code.PJSIP_SC_BUSY_EVERYWHERE;
      case decline:
        return pjsip_status_code.PJSIP_SC_DECLINE;
      case doesNotExistAnywhere:
        return pjsip_status_code.PJSIP_SC_DOES_NOT_EXIST_ANYWHERE;
      case notAcceptableAnywhere:
        return pjsip_status_code.PJSIP_SC_NOT_ACCEPTABLE_ANYWHERE;
      case unwanted:
        return pjsip_status_code.PJSIP_SC_UNWANTED;
      case rejected:
        return pjsip_status_code.PJSIP_SC_REJECTED;
      case tsxTimeout:
        return pjsip_status_code.PJSIP_SC_TSX_TIMEOUT;
      case tsxTransportError:
        return pjsip_status_code.PJSIP_SC_TSX_TRANSPORT_ERROR;
      case tsxResolvError:
        return 702;
    }
  }
}
