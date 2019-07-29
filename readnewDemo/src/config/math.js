/**
 * 金额验证
 */
const regMoney = /^[0-9]*[\.]{0,1}[0-9]*$/;
/**
 * 非空字符串
 */
const regEmptyString = / /g;

/**
 * @description 金额验证
 */
export const checkMoney = (amount, max = NaN, min = 0) => {
    const r = regMoney.test(amount)
    if (!r) return false;
    if (max.toString() !== 'NaN' && parseFloat(amount) > max) return false;
    if (parseFloat(amount) < min) return false;
    return trimString(amount) ? true : false;
}
/**
 * 非空字符串
 */
export const trimString = (str) => {
    if (!str) return '';
    return str.toString().replace(regEmptyString, '')
}
