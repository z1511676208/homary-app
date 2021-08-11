/*
 * @Author       : JHao
 * @Date         : 2021-06-21 18:40:47
 * @LastEditors  : zhhjie
 * @LastEditTime : 2021-08-10 11:22:53
 */
/// 是否开启代理
/// 判断当前环境是否 release (生产环境)
bool isRelease = bool.fromEnvironment("dart.vm.product");

final bool openProxy = !isRelease;

/// 代理服务IP
const PROXY_IP = '10.0.1.70';

//代理服务端口
const PROXY_PORT = 8866;
