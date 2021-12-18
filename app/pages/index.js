import { Header, Footer } from '@button-inc/bcgov-theme';
import JsonSchemaForm from '@rjsf/semantic-ui';
import schema from '../schemas/schema';

export default function Home() {
  return (
    <>
      <JsonSchemaForm
        schema={schema}
      >
      </JsonSchemaForm>
    </>
  )
};
