# Defined in - @ line 1
function run_yas --wraps='cargo build && sudo chown root target/debug/yas && sudo chmod u+s target/debug/yas && ./target/debug/yas echo hi' --description 'alias run_yas cargo build && sudo chown root target/debug/yas && sudo chmod u+s target/debug/yas && ./target/debug/yas echo hi'
  cargo build && sudo chown root target/debug/yas && sudo chmod u+s target/debug/yas && ./target/debug/yas echo hi $argv;
end
