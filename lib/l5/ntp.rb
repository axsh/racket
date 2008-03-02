class NTP < RacketPart
  # Leap Indicator
  unsigned :leap, 2
  # Local Clock Status
  unsigned :status, 6
  # Reference Clock Type
  unsigned :type, 8
  # Local Clock Precision
  unsigned :precision, 16
  # Estimated Error
  unsigned :error_est, 32
  # Estimated Drift Rate
  unsigned :drift_est, 32
  # Reference Clock Identifier
  unsigned :ref_clock, 32
  # Reference Timestamp
  unsigned :ref_ts, 64
  # Originate Timestamp
  unsigned :orig_ts, 64
  # Receive Timestamp
  unsigned :rec_ts, 64
  # Transmit Timestamp
  unsigned :tr_ts, 64
  rest :payload
end
# vim: set ts=2 et sw=2:

