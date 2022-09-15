import {
  DIDResolutionOptions,
  DIDResolutionResult,
  ParsedDID,
  Resolver,
} from "did-resolver";
import axios from "axios";

export function getResolver(
  /**
   * Base URL of the PPLDID resolver
   * Resolver implementation can be found at https://github.com/peopledata/ppldid
   * 
   * Default: https://ppld-resolver.peopledata.org.cn
   */
  baseUrl: string = 'http://ppldid.peopledata.org.cn:3000',
) {
  async function resolve(
    did: string,
    // @ts-expect-error we currently use the raw did string
    parsed: ParsedDID,
    // @ts-expect-error currently no parent lookup is supported
    didResolver: Resolver,
    // @ts-expect-error also not supported at the moment
    options: DIDResolutionOptions
  ): Promise<DIDResolutionResult> {
    const didDoc = await axios.get(`${baseUrl}/1.0/identifiers/${did}`);
    
    // resolver directly delivers needed did resolution result
    return (didDoc.data as DIDResolutionResult);
  }

  return { ppld: resolve }
}