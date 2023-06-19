import {
  DIDResolutionOptions,
  DIDResolutionResult,
  ParsedDID,
  Resolver,
} from "did-resolver";
import axios from "axios";

export function getResolver(
  /**
   * Base URL of the PPLCDID resolver
   * Resolver implementation can be found at https://github.com/peoplecarbon/pplcdid
   * 
   * Default: https://pplc-resolver.peoplecarbon.org
   */
  baseUrl: string = 'http://pplcdid.peoplecarbon.org:3000',
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