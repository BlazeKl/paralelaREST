import jwt from 'jsonwebtoken';

function jwtTokens({id,email}) {
    const user = {id,email};
    const token = jwt.sign(user,process.env.ACCESS_TOKEN_SECRET,{expiresIn:'15s'});
    const rtoken = jwt.sign(user,process.env.REFRESH_TOKEN_SECRET,{expiresIn:'15m'});
    return ({token,rtoken});
}

export {jwtTokens};