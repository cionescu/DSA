import React, { Component } from 'react';
import axios from 'axios';
import './App.css';
import { Grid, Row, Col, Form, FormGroup, FormControl, ControlLabel, Button, Panel, Alert, Pager } from 'react-bootstrap'

const USER_QUERY = `
  query ($user: String!, $after: String, $before: String) {
    user(login: $user) {
      company
      name
      url
      repositories(first: 5, after: $after, before: $before) {
        totalCount
        pageInfo {
          hasNextPage
          hasPreviousPage
          startCursor
          endCursor
        }
        edges {
          node {
            description
            name
            url
          }
        }
      }
    }
  }
`

const axiosGitHubGraphQL = axios.create({
  baseURL: 'https://api.github.com/graphql',
  headers: {
    Authorization: "bearer b344d9b75961e7162dec1cdb75e14dd438246fc7"
  },
});

class App extends Component {
  constructor(props) {
    super(props)

    this.state = { "path": "cionescu", "user": null, "errors": null, currentPage: 1, pageInfo: null }

    this.prevPage = this.prevPage.bind(this);
    this.nextPage = this.nextPage.bind(this);
  }

  fetchData(user, after, before) {
    axiosGitHubGraphQL
      .post('', { query: USER_QUERY, variables: { user, after } })
      .then(result => {
        if (result.data.data && result.data.data.user) {
          this.setState({ "user": result.data.data.user, pageInfo: result.data.data.user.repositories.pageInfo })
        } else {
          this.setState({ "errors": result.data.errors })
        }
      })
  }

  onChange = event => {
    this.setState({ path: event.target.value })
  };

  onSubmit = event => {
    this.setState({ user: null, errors: null, currentPage: 1, pageInfo: null })
    this.fetchData(this.state.path, null, null)

    event.preventDefault();
  }

  prevPage = () => {
    const { currentPage, pageInfo, path } = this.state
    this.fetchData(path, null, pageInfo.startCursor)
    this.setState({ currentPage: currentPage - 1 })
  }

  nextPage = () => {
    const { currentPage, pageInfo, path } = this.state
    this.fetchData(path, pageInfo.endCursor, null)
    this.setState({ currentPage: currentPage + 1 })
  }

  render() {
    const { path, user, errors, currentPage } = this.state

    return (
      <Grid>
        <Row className="show-grid">
          <Col md={8} mdOffset={2} >
            <h1>Graphql</h1>

            <Form inline onSubmit={this.onSubmit}>
              <FormGroup controlId="formInlineName">
                <ControlLabel>Show open issues for https://github.com/</ControlLabel>{' '}
                <FormControl
                  type="text"
                  value={path}
                  onChange={this.onChange} />
              </FormGroup>{' '}
              <Button type="submit">Search</Button>
            </Form>

            <hr />

            {(user || errors) ? (<User user={user} errors={errors} prevPage={this.prevPage} nextPage={this.nextPage} currentPage={currentPage} />) : <p>No information yet ...</p> }
          </Col>
        </Row>
      </Grid>
    )
  }
}

const User = ({ user, errors, prevPage, nextPage, currentPage }) => {
  if (errors) {
    return (
      <Alert bsStyle="danger">
        <strong>Something went wrong:</strong>
        {errors.map(error => error.message).join(' ')}
      </Alert>
    )
  }
  return (
    <React.Fragment>
      <Panel>
        <h3>{user.name}</h3>
        <a href={user.url}>{user.company}</a>
      </Panel>
      <Repositories repositories={user.repositories} prevPage={prevPage} nextPage={nextPage} currentPage={currentPage} />
    </React.Fragment>
  )
}

const Repositories = ({ repositories, prevPage, nextPage, currentPage }) => {
  const { totalCount, edges, pageInfo } = repositories

  return (
    <div>
      <p className="text-muted">Found {totalCount}</p>
      {edges.map((repository, idx) => (
        <Panel key={idx}>
          <h3>{repository.node.name}</h3>
          <p className="text-muted">{repository.node.description}</p>
          <a href={repository.node.url} target="_blank">Link</a>
        </Panel>
      ))}
      <Pager>
        {currentPage > 1 && <Pager.Item href="#" onClick={prevPage}>Previous</Pager.Item>}
        Page {currentPage} of {Math.ceil(totalCount / 5)}
        {currentPage < Math.ceil(totalCount / 5) && <Pager.Item href="#" onClick={nextPage}>Next</Pager.Item>}
      </Pager>
    </div>
  )
}

export default App;
