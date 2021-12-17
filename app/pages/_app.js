import { Header, Footer } from '@button-inc/bcgov-theme';
import '../styles/globals.css'

function MyApp({ Component, pageProps }) {
  return (
    <>
      <Header
        header="main"
        onBannerClick={function noRefCheck() { }}
        title="Welcome to the Connectivity Engagement"
      />
      <Component {...pageProps} />
      <Footer>
        <ul>
          <li>
            <a href=".">
              About
            </a>
          </li>
          <li>
            <a href=".">
              Careers
            </a>
          </li>
          <li>
            <a href=".">
              Privacy Policy
            </a>
          </li>
        </ul>
      </Footer>
    </>
  )
}

export default MyApp
