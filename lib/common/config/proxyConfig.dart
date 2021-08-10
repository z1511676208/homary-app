/*
 * @Author       : JHao
 * @Date         : 2021-06-21 18:40:47
 * @LastEditors  : JHao
 * @LastEditTime : 2021-08-09 14:19:34
 */
/// 是否开启代理
/// 判断当前环境是否 release (生产环境)
bool isRelease = bool.fromEnvironment("dart.vm.product");

final bool openProxy = !isRelease;

/// 代理服务IP
const PROXY_IP = '10.0.1.83';

/// 代理服务端口
const PROXY_PORT = 8866;
