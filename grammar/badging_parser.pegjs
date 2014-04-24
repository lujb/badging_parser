/* Badging parser grammar. */

start
  = value:line+ {
    var result = {};
    for (var i=0; i< value.length; i++) {
      if (value[i] !== null) {
        if (value[i][1].length===1) {
          result[value[i][0]] = value[i][1][0];
      } else {
          result[value[i][0]] = value[i][1];
        }
      }
    }
    return result;
  }

line
  = [a-zA-Z-]+ _* nl {return null;}
  / name:[^:]+ ':' _* value:value nl* {return [name.join(''), value];}

value
  = str_value
  / kv_value

one
  =  "''" {return undefined;} 
  / "'" value:[^']+ "'" _* {return value.join('');}

str_value
  = head:one tail:(',' _* one)+ {
    var result = [head];
    for (var i=0; i< tail.length; i++) {
      result.push(tail[i][2]);
    }
    return result;
  }
  / value:one+ {return value;}

kv_value
  = value:pair+ {
    var result = {};
    for(var i=0; i<value.length; i++) {
      result[value[i][0]] = value[i][1];
    }
    return result;
  }

pair 
  = key:[a-zA-Z]+ "=" value:one {return [key.join(''), value];}

nl
  = [\n\r]
_
  = [ \t]

