# Domain Name System
class DNS < RacketPart
  # Transaction ID
  unsigned :tx_id, 16
  # Response
  unsigned :response, 1
  # Opcode
  unsigned :opcode, 4
  # Authoritative?
  unsigned :authoritative, 1
  # Truncated?
  unsigned :truncated, 1
  # Recursion Desired?
  unsigned :recursion_d, 1
  # Recursion Available?
  unsigned :recursion_a, 1
  # Reserved
  unsigned :reserved, 1
  # Answer authenticated?
  unsigned :auth, 1
  # Non-authenticated data OK?
  unsigned :nonauth, 1
  # Reply Code
  unsigned :reply_code, 4
  # Number of questions
  unsigned :question_rr, 16
  # Number of answer RR
  unsigned :answer_rr, 16
  # Number of authority RR
  unsigned :authority_rr, 16
  # Number of additional RR
  unsigned :additional_rr, 16
  rest :payload

  def initialize(*args)
    super
  end

  # Add an additional record.  Automatically increases +additional_rr+
  def add_additional(name, type, klass)
    self.payload += self.add_record(name, type, klass).encode
    self.additional_rr += 1
  end

  # Add an answer record.  Automatically increases +answer_rr+
  def add_answer(name, type, klass)
    self.payload += self.add_record(name, type, klass).encode
    self.answer_rr += 1
  end

  # Add an authority record.  Automatically increases +authority_rr+
  # XXX: broken.  authns records are much more complicated than this.
  def add_authority(name, type, klass)
    self.payload += self.add_record(name, type, klass).encode
    self.authority_rr += 1
  end

  # Add a question record.  Automatically increases +question_rr+
  def add_question(name, type, klass)
    self.payload += add_record(name, type, klass).encode
    self.question_rr += 1
  end

private
  def add_record(name, type, klass)
    q = VT.new(2,2)
    name.split(/\./).each do |p|
      lv = LV.new(1)
      lv.values << p
      lv.lengths << p.length
      q.value << lv.encode 
    end
    q.types << type
    q.types << klass
    q
  end

end
# vim: set ts=2 et sw=2:
